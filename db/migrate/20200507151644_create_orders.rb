class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.boolean :is_checked, { null: false, default: false }
      t.string :billing_address
      t.string :shipping_address

      t.timestamps
    end
  end
end
