# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_info =   [
  {email: Faker::Internet.email, password: "password"},
  {email: Faker::Internet.email, password: "password", premium: true},
  {email: Faker::Internet.email, password: "password", admin: true}
]
users = []
user_info.each do |user_info|
  users.push(User.new(user_info))
end

20.times do
  wiki = users.sample.wikis.build({
    title: Faker::Company.bs,
    body: Faker::Lorem.paragraphs(rand(2..8)).join(" ")
    })
end

users.each do |user|
    user.skip_confirmation!
    user.save!
end


p "Seed completed."
p "#{User.all.count} users available."
p "#{Wiki.all.count} wikis available."
