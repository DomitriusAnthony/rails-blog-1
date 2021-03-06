# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

def ids_generation(id)
  if id + 1 > 5
    1
  else
    id + 1
  end
end

5.times do |t|
  User.new.tap do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.email = Faker::Internet.email
    user.password = '12345678'
    user.save
  end
end

users = User.all

users.each do |user|
  3.times do
    user.posts.create(title: Faker::Lorem.sentence,
                      body: Faker::Lorem.paragraph)
  end
end

posts = Post.all

posts.each do |post|
  3.times do
    Comment.create(body: Faker::Lorem.sentence,
                   user_id: rand(1..5),
                   post_id: post.id)
  end
end

users.each do |user|
  Relationship.create(follower_id: user.id,
                      followed_id: ids_generation(user.id))
end
