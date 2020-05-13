class Order < ApplicationRecord
  belongs_to :user
  has_many :OrderProducts
  has_many :products, through: :OrderProducts
  # has_many :products, :through => :orders_products
end
