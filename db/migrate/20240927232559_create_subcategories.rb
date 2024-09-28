class CreateSubcategories < ActiveRecord::Migration[7.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
