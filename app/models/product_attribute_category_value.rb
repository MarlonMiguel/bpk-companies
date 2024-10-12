class ProductAttributeCategoryValue < ApplicationRecord
  belongs_to :product
  belongs_to :category_attribute
end
