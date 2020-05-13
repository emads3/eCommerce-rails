class Product < ApplicationRecord
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON

  belongs_to :category
  belongs_to :brand
  belongs_to :store
  # belongs_to :user
  has_many :product_shoppings, :dependent => :destroy

  # example
  # Order.first.OrderProducts[0].quantity
  has_many :OrderProducts, :dependent => :destroy
  has_many :orders, :through => :OrderProducts

  has_many :shopping_carts, :through => :product_shoppings
  has_many :product_imgs
  accepts_nested_attributes_for :product_imgs

end
