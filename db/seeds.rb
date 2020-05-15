# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'nouran@yahoo.com', password: '987*654*321', password_confirmation: '987*654*321') if Rails.env.development?
AdminUser.create!(email: 'e@emads3.com', password: '123123123', password_confirmation: '123123123') if Rails.env.development?

%w[Adidas Samsung Apple].each { |brand| Brand.create(name: brand) }

['Electrical Devices', 'Mobile Devices', 'Computers And Accessories'].each do |cat|
  Category.create(name: cat)
end

user1 = User.new
user1.name = 'Emad S.'
user1.email = 'e@emads3.com'
user1.password = '123123123'
user1.is_seller = true
user1.save!

user2 = User.new
user2.name = 'Omda '
user2.email = 'emad.fcis@gmail.com'
user2.password = '123123123'
user2.save!


['Modern Home', 'SOUQ', 'Furniture Store', 'Select Mobile', '2B', 'Tradeline'].each do
|store|
  Store.create(name: store, user_id: [user1.id, user2.id].sample)
end
