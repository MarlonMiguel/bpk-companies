class PagesController < ApplicationController
  def store
    @categories = Category.all
    @categories_filter = Category.includes(:subcategories).where(parent_id: nil)
    @product_counts = Product.where(active: true).group(:category_id).count
    @products = Product.joins(:category).where(active: true)

    # Filtro por categoria selecionada ou ids de categorias múltiplas
    if params[:category_ids].present?
      @products = @products.where(category_id: params[:category_ids])
    elsif params[:category_id].present?
      selected_category = Category.find_by(id: params[:category_id])
      if selected_category
        category_ids = [selected_category.id] + selected_category.subcategories.pluck(:id)
        @products = @products.where(category_id: category_ids)
      end
    end

    # Filtros adicionais
    @products = @products.where('LOWER(products.name) LIKE ?', "%#{params[:name].downcase}%") if params[:name].present?
    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price].present?
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price].present?

    # Evitar produtos duplicados na listagem final
    @products = @products.distinct

    # Renderização condicional para AJAX ou página completa
    if request.xhr?  # Se for uma requisição Turbo, vai renderizar somente a parte específica
      render turbo_stream: turbo_stream.replace('products-list', partial: 'products_list', locals: { products: @products })
    else
      # Caso contrário, renderiza a página normalmente
      render :store
    end
  end
end
