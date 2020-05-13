# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'nouran@yahoo.com', password: '987*654*321', password_confirmation: '987*654*321') if Rails.env.development?
AdminUser.create!(email: 'e@emads3.com', password: '123123123', password_confirmation: '123123123') if Rails.env.development?

# User.create(email: 'emad.fcis@gmail.com', encrypted_password: '123123123', created_at: '2020-05-13 03:45:15.000', updated_at: '2020-05-13 03:45:15.000')

Brand.create(name: 'Adidas') if Rails.env.development?
Brand.create(name: 'Samsung') if Rails.env.development?

Category.create(name: 'Electrical Devices')
Category.create(name: 'Mobile Devices')
Category.create(name: 'Computers And Accessories')

# Store.create
