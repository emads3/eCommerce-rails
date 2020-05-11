class Product < ApplicationRecord
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON
  
  belongs_to :category
  belongs_to :brand
  belongs_to :store
  belongs_to :user
  has_and_belongs_to_many :orders
  has_many :product_shoppings
  has_many :shopping_carts, :through => :product_shoppings
  has_many :product_imgs
  accepts_nested_attributes_for :product_imgs

end
