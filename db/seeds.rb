# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

User.create(
  email: 'luke@luke.com',
  password: 'testing',
  password_confirmation: 'testing',
  username: 'lukeomalley',
  first_name: 'Luke',
  last_name: 'OMalley',
  city: 'Washington D.C.',
  occupation: 'Software Engineer'
)

100.times do
  User.create(
    email: Faker::Internet.email,
    password: 'testing',
    password_confirmation: 'testing',
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: Faker::Address.city,
    occupation: Faker::Job.title
  )
end

User.all.each do |user|
  luke = User.find_by(email: 'luke@luke.com')
  Match.create(user: user, liked_user: luke)
end
