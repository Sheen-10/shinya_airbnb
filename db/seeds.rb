# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create!(
  fullname: "Johnedel Mapa",
  email: "johnedel.mapa@sun-asterisk.com",
  password: "password",
  password_confirmation: "password"
)

user.skip_confirmation!
user.save

user1 = User.create!(
  fullname: "Shinya Mori",
  email: "shinya199905102525@gmail.com",
  password: "password",
  password_confirmation: "password"
)

user1.skip_confirmation!
user1.save


50.times do |n|
  users = User.new(
  fullname: Faker::Name.name,
  email: Faker::Internet.unique.email,
  password: "password",
  password_confirmation: "password"
)
users.skip_confirmation!
users.save!
end