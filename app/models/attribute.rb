class Attribute < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: 'category_attributes'
  belongs_to :category
  has_many :product_attribute_category_values
end
