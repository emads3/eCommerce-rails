class AddAvatarsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :avatars, :string
  end
end
