class AddSellerToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :seller, foreign_key: true
  end
end
