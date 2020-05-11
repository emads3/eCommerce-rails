class AddQtyToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :qty, :integer
  end
end
