class Category < ApplicationRecord
    has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
    belongs_to :parent, class_name: 'Category', optional: true

    has_and_belongs_to_many :custom_attributes, class_name: 'Attribute', join_table: 'category_attributes'
    has_and_belongs_to_many :users

    has_many :product_attribute_category_values
  
    validate :parent_cannot_be_self, if: -> { parent_id.present? }

    validate :parent_cannot_be_self, if: -> { parent_id.present? }

    private
    
    def parent_cannot_be_self
      if parent_id == id
        errors.add(:parent_id, "não pode ser igual ao ID da categoria.")
      end
    end
    
    before_destroy :check_for_subcategories

    private

    def check_for_subcategories
      if subcategories.exists?
        errors.add(:base, "Não é possível excluir uma categoria que possui subcategorias.")
        throw(:abort) 
      end
    end
end
