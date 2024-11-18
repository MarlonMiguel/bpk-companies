class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :product_attribute_category_values, dependent: :destroy
  belongs_to :category

  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  def self.filtered(params)
    products = all

    if params[:name].present?
      products = products.where("name ILIKE ?", "%#{params[:name]}%")
    end

    if params[:min_price].present?
      products = products.where("price >= ?", params[:min_price].to_f)
    end

    if params[:max_price].present?
      products = products.where("price <= ?", params[:max_price].to_f)
    end

    if params[:category_ids].present?
      products = products.joins(:categories).where(categories: { id: params[:category_ids] })
    end

    products
  end
end
