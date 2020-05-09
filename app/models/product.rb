class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  belongs_to :store
  has_many :product_shoppings
  has_many :shopping_carts, :through => :product_shoppings
  has_many :product_imgs
  accepts_nested_attributes_for :product_imgs

end
