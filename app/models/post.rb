class Post < ApplicationRecord
  has_many :likes, as: :item
  has_many :comments, dependent: :destroy
  validates :body,:title, presence: true
  belongs_to :user

  def self.generate_posts(n = 5, user = nil)
    user ||= User.last

    n.times do
        body = ' '+ Faker::Hobbit.quote
        post = Post.create!(
        title: Faker::Cat.breed,
        body: body,
        user: User.random_user
      )

      rand(8).times do
        post.comments.create(
          body: Faker::Hacker.say_something_smart,
          user: User.random_user
        )
      end

      rand(30).times do
        post.likes.create(
          user: User.random_user,
        )
      end
    end
  end
end
