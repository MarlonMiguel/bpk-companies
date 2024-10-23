class AddIdToCategoryAttributes < ActiveRecord::Migration[7.1]
  def change
    add_column :category_attributes, :id, :primary_key
  end
end
