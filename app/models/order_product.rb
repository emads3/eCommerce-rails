class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
  self.table_name = 'orders_products'
end
