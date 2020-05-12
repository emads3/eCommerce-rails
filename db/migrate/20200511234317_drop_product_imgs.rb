class DropProductImgs < ActiveRecord::Migration[6.0]
  def change
    drop_table :product_imgs
  end
end
