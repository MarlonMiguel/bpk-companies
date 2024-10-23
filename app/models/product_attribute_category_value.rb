class ProductAttributeCategoryValue < ApplicationRecord
  belongs_to :product
  belongs_to :category
  belongs_to :category_attribute, class_name: 'Attribute'
end
