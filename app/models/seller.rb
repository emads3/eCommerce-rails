class Seller < ApplicationRecord
    has_many :products , dependent: :destroy
    has_many :orders, through: :products

end
