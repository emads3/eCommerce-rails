class Product < ApplicationRecord
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON

  belongs_to :category
  belongs_to :brand
  belongs_to :store
  belongs_to :user
  has_many :product_shoppings, :dependent => :destroy
  belongs_to :order, :through => :order_products
=begin
  has_many :product_orders, :dependent => :destroy
  has_many :orders, :through => :product_orders
=end


  has_many :shopping_carts, :through => :product_shoppings
  has_many :product_imgs
  accepts_nested_attributes_for :product_imgs

end
