class PagesController < ApplicationController

  def store
    @categories = Category.all
    @products = Product.joins(:category).where(active: true) 

    @categories_filter = Category.includes(:subcategories).where(parent_id: nil) # Carrega todas as categorias sem pai
    @selected_category = Category.find_by(id: params[:category_id]) 
    @product_counts = Product.where(active: true).group(:category_id).count


    if @selected_category
      @products = @products.where(category_id: @selected_category.id)
    end

    if params[:category].present?
      @products = @products.where('LOWER(categories.description) = ?', params[:category].downcase)
    end

    if params[:name].present?
      @products = @products.where('LOWER(products.name) LIKE ?', "%#{params[:name].downcase}%")
    end

    if params[:min_price].present?
      @products = @products.where('price >= ?', params[:min_price])
    end

    if params[:max_price].present?
      @products = @products.where('price <= ?', params[:max_price])
    end

    if params[:category_ids].present?
      @products = @products.where(category_id: params[:category_ids])
    end

    @products = @products.distinct 
  end

end
