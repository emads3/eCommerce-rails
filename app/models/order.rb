class Order < ApplicationRecord
    belongs_to :user
    has_many :sellers, :through => :products
    has_many :products, :through => :product_orders

end
