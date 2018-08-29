# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "votanphu.2101@gmail.com", password:"12345678", name: "Sunny")
User.generate_users(30, "male")
User.generate_users(30)
Post.generate_posts(20, User.find_by_name("Sunny"))
