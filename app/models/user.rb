class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def is_admin?
    return true if role == "ADMIN"
  end

  # Check whether user is exist if not create one
  def self.create_user(email, role)
    new_password = SecureRandom.base64(16)
    temp_name = email.split("@")[0]
    user_attributes = {
      email: email,
      password: new_password,
      password_confirmation: new_password,
      role: role,
    }

    user = User.new(user_attributes)

    if user.save!
      UserMailer.welcome_email(
        email: user.email
      ).deliver_later
    end

    return user
  end

  def self.generate_users(n = 5, gender = "female")
    url = "https://randomuser.me/api?results=#{n}&gender=#{gender}"
    body = HTTP.get(url).parse

    body["results"].each do |person|
      hash = {}
      hash[:name] = person["name"]["first"] + " " + person["name"]["last"]
      hash[:email] = person["email"]
      o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      string = (0...10).map { o[rand(o.length)] }.join
      hash[:password] = string
      hash[:image_url] = person["picture"]["large"]
      user = User.create! hash
    end
  end

  def liking?(item)
    likes.where(item: item).exists?
  end

  def toggle_like!(item)
    if like = likes.where(item: item).first
      like.destroy
    else
      likes.where(item: item).create!
    end
  end

  def self.random_user
    User.offset(rand User.count).first
  end
end
