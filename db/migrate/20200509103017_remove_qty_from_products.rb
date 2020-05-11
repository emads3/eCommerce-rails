class RemoveQtyFromProducts < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :qty, :integer
  end
end
