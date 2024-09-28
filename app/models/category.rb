class Category < ApplicationRecord
    has_many :subcategories # Certifique-se de que o nome está correto
end
