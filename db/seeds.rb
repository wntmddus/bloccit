# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'
15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all
 # Create Posts
 50.times do
 # #1
   Post.create!(
 # #2
     topic:  topics.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 posts = Post.all

 # Create Comments
 # #3
 100.times do
   Comment.create!(
 # #4
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end
 5.times do
   Advertisement.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_price
   )
 end

 5.times do
   SponsoredPost.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_price
   )
 end

 100.times do
   Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false
   )
 end
puts "#{Post.count}"
Post.find_or_create_by(title: "here is title", body: "Here is body")
puts "#{Post.count}"

 puts "Seed finished"
 puts "#{Topic.count} topics created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 puts "#{Question.count} questions created"
 puts "#{SponsoredPost.count} sponsored posts created"
