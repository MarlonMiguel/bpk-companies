class PagesController < ApplicationController
  # def store
  #   @category = params[:category]
  #   @name_filter = params[:name]
  #   @value_filter = params[:value]
  
  #   @products = Product.all
  
  #   # Filtrando por categoria, se a categoria for passada
  #   if @category.present?
  #     @products = @products.where('LOWER(category.description) = ?', @category.downcase)
  #   end
  
  #   # Filtrando por nome, se o filtro de nome for passado
  #   if @name_filter.present?
  #     @products = @products.where('LOWER(name) LIKE ?', "%#{@name_filter.downcase}%")
  #   end
  
  #   # Filtrando por valor, se o filtro de valor for passado
  #   if @value_filter.present?
  #     @products = @products.where('price <= ?', @value_filter)
  #   end
  # end

  def store
    # Inicializa a consulta com os produtos
    @products = Product.joins(:category) # Assegura que estamos unindo a tabela categories

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
