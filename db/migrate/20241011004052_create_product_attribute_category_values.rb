class CreateProductAttributeCategoryValues < ActiveRecord::Migration[7.1]
  def change
    create_table :product_attribute_category_values do |t|
      t.references :product, null: false, foreign_key: true
      t.references :category_attribute, null: false, foreign_key: { to_table: :category_attributes, column: :attribute_id }
      t.string :value

      t.timestamps
    end
  end
end
