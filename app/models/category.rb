class Category < ApplicationRecord
    has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
    has_many :products
    belongs_to :parent, class_name: 'Category', optional: true
    has_many :product_attribute_category_values

    has_and_belongs_to_many :custom_attributes, class_name: 'Attribute', join_table: 'category_attributes'
    has_and_belongs_to_many :users

    before_destroy :check_dependencies
  
    validate :parent_cannot_be_self, if: -> { parent_id.present? }

    def full_description
      parent ? "#{parent.full_description} -> #{description}" : description
    end

    private
    
    def parent_cannot_be_self
      if parent_id == id
        errors.add(:parent_id, "não pode ser igual ao ID da categoria.")
      end
    end
    
    before_destroy :check_for_subcategories

    private

    def check_dependencies
      if products.exists?
        errors.add(:base, "Não é possível excluir a categoria porque existem produtos associados a ela.")
        throw(:abort) # Impede a exclusão
      elsif users.exists?
        errors.add(:base, "Não é possível excluir a categoria porque existem vendedores associados a ela.")
        throw(:abort)
      elsif custom_attributes.exists?
        errors.add(:base, "Não é possível excluir a categoria porque existem atributos associados a ela.")
        throw(:abort)
      elsif subcategories.exists?
        errors.add(:base, "Não é possível excluir uma categoria que possui subcategorias.")
        throw(:abort) 
      end
    end
end
