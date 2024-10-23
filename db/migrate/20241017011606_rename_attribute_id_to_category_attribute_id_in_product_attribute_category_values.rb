class RenameAttributeIdToCategoryAttributeIdInProductAttributeCategoryValues < ActiveRecord::Migration[7.1]
  def change
    rename_column :product_attribute_category_values, :attribute_id, :category_attribute_id
  end
end
