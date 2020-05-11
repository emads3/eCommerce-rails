class DropCreateOrdersProduct < ActiveRecord::Migration[6.0]
  def up
    drop_table :create_orders_products
  end
end
