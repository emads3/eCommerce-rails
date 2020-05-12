class AddIsCheckedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :is_checked, :boolean,
               null: false, default: false
  end
end
