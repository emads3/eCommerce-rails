class CreateOrdersProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_products do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity, { null: false, default: 1 }
      t.string :product_seller_confirmation_state, { null: false, default: 1 }
    end
  end
end
