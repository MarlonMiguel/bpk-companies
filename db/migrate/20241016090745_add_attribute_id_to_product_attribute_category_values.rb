class AddAttributeIdToProductAttributeCategoryValues < ActiveRecord::Migration[7.1]
  def change
    add_column :product_attribute_category_values, :attribute_id, :integer
    add_index :product_attribute_category_values, :attribute_id 
  end
end
