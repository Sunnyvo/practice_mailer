class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
