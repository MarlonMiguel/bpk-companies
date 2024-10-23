class RemoveCategoryAttributeIdFromProductAttributeCategoryValues < ActiveRecord::Migration[7.1]
  def change
    remove_column :product_attribute_category_values, :category_attribute_id, :integer
  end
end
