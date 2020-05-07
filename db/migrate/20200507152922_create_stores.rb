class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :summary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
