class CreateCategors < ActiveRecord::Migration[6.0]
  def change
    create_table :categors do |t|
      t.string :name

      t.timestamps
    end
  end
end
