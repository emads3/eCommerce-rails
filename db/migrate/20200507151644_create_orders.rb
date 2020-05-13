class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :state
      t.boolean :is_checked, { null: false, default: false }

      t.timestamps
    end
  end
end
