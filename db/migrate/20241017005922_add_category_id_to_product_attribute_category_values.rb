class AddCategoryIdToProductAttributeCategoryValues < ActiveRecord::Migration[7.1]
  def change
    add_column :product_attribute_category_values, :category_id, :integer
  end
end
