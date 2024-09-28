class Subcategory < ApplicationRecord
    belongs_to :parent, class_name: 'Subcategory', optional: true
    has_many :subcategories, class_name: 'Subcategory', foreign_key: 'parent_id'
end
