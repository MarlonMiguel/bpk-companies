class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :product_attribute_category_values
  belongs_to :category

  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
