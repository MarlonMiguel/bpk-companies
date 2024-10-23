class CreateCategoryAttributesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :category_attributes, id: false do |t|
      t.references :category, null: false, foreign_key: true
      t.references :attribute, null: false, foreign_key: { to_table: :attributes }
    end

    add_index :category_attributes, [:category_id, :attribute_id], unique: true
  end
end
