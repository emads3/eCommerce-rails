class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :product_shoppings
  has_many :products, :through => :product_shoppings
end
