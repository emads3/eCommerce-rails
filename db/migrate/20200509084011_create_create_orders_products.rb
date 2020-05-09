class CreateCreateOrdersProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :create_orders_products ,:id=>false do |t|
      t.integer "order_id"
      t.integer "product_id"

      t.timestamps
    end
  end
end
