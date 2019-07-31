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
Match.destroy_all
Skill.destroy_all

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
downloaded_image = open("https://thispersondoesnotexist.com/image")
luke.avatar.attach(io: downloaded_image, filename: "image.jpg")

lisa = User.create(
  email: 'lisa@lisa.com',
  password: 'testing',
  password_confirmation: 'testing',
  username: 'lisaantwi',
  first_name: 'Lisa',
  last_name: 'Antwi',
  city: 'Washington D.C.',
  occupation: 'Software Engineer'
)
downloaded_image = open("https://thispersondoesnotexist.com/image")
lisa.avatar.attach(io: downloaded_image, filename: "image.jpg")

25.times do
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
  downloaded_image = open("https://thispersondoesnotexist.com/image")
  user.avatar.attach(io: downloaded_image, filename: "image.jpg")
end

User.all.each do |user|
  luke = User.find_by(email: 'luke@luke.com')
  Match.create(user: user, liked_user: luke)
end

Skill.create(name: 'ruby')
Skill.create(name: 'python')
Skill.create(name: 'javascript')
Skill.create(name: 'rails')
Skill.create(name:'html')
Skill.create(name: 'css')
