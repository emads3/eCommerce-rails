class CreateProductShoppings < ActiveRecord::Migration[6.0]
  def change
    create_table :product_shoppings do |t|
      t.references :shopping_cart, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
