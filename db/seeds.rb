# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

User.destroy_all

luke = User.create(
  email: 'luke@luke.com',
  password: 'testing',
  password_confirmation: 'testing',
  username: 'lukeomalley',
  first_name: 'Luke',
  last_name: 'OMalley',
  city: 'Washington D.C.',
  occupation: 'Software Engineer'
)
downloaded_image = open("https://source.unsplash.com/400x400/?face")
luke.avatar.attach(io: downloaded_image, filename: "image.jpg")

3.times do
  user = User.create(
    email: Faker::Internet.email,
    password: 'testing',
    password_confirmation: 'testing',
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: Faker::Address.city,
    occupation: Faker::Job.title
  )
  downloaded_image = open("https://source.unsplash.com/400x400/?face")
  user.avatar.attach(io: downloaded_image, filename: "image.jpg")
end

User.all.each do |user|
  luke = User.find_by(email: 'luke@luke.com')
  Match.create(user: user, liked_user: luke)
end
