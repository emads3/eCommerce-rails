class CreateProductOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :product_orders do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.integer :quantity, null: false, default: 1
      t.string :state
      t.timestamps
    end
  end
end
