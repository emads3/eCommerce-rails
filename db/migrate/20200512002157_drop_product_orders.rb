class DropProductOrders < ActiveRecord::Migration[6.0]
  def change
      drop_table :order_products
  end
end
