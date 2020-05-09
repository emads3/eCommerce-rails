class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  belongs_to :store
  belongs_to :seller
  has_and_belongs_to_many :orders

end
