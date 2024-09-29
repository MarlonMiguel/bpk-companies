class Category < ApplicationRecord
    # Associações para gerenciar categorias pai e filho
    has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
    belongs_to :parent, class_name: 'Category', optional: true

    # Validação (opcional) para garantir que a categoria não possa ser uma subcategoria de si mesma
    validate :parent_cannot_be_self, if: -> { parent_id.present? }

    private
    
    def parent_cannot_be_self
      if parent_id == id
        errors.add(:parent_id, "não pode ser igual ao ID da categoria.")
      end
    end
end
