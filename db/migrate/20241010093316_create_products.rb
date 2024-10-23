class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :priority
      t.boolean :active
      t.integer :category_id

      t.timestamps
    end
  end
end
