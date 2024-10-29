class PagesController < ApplicationController

  def store

    @products = Product.joins(:category).where(active: true) 

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

    @products = @products.distinct 
  end
end
