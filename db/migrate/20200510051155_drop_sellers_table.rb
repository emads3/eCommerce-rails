class DropSellersTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :sellers
  end
end
