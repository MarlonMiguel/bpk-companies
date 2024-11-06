class ProductsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy, :toggle_active]
  before_action :authorize_user!, only: %i[ edit update destroy ]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  # GET /products or /products.json
  def index
    if user_signed_in? && current_user.admin?  
      @products = Product.all  
    else
      @products = current_user.products  
    end

    # Paginação
    @per_page = 6 
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_products = @products.count
    @total_pages = (@total_products / @per_page.to_f).ceil

    @products = @products.limit(@per_page).offset((@page - 1) * @per_page)
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new

    if current_user.admin?
      @categories = Category.left_joins(:subcategories).where(subcategories_categories: { id: nil })
    else
      # Se o usuário for vendedor, traz as categorias associadas ao vendedor
      @categories = current_user.categories.left_joins(:subcategories).where(subcategories_categories: { id: nil })
    end
  
    # Debug: Mostrar as categorias no log
    logger.debug "Categorias recuperadas: #{@categories.inspect}"
  
    # Se o vendedor não tem categorias, exibe a mensagem
    if @categories.empty?
      flash.now[:alert] = "Você não possui categorias vinculadas. Por favor, peça para o administrador vincular uma categoria a você."
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    if current_user.admin?
      @categories = Category.left_joins(:subcategories).where(subcategories_categories: { id: nil })
    else
      # Se o usuário for vendedor, traz as categorias associadas ao vendedor
      @categories = current_user.categories.left_joins(:subcategories).where(subcategories_categories: { id: nil })
    end
  
    # Debug: Mostrar as categorias no log
    logger.debug "Categorias recuperadas: #{@categories.inspect}"
  
    # Se o vendedor não tem categorias, exibe a mensagem
    if @categories.empty?
      flash.now[:alert] = "Você não possui categorias vinculadas. Por favor, peça para o administrador vincular uma categoria a você."
    end
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        save_dynamic_attributes(params[:product][:attributes])
        format.html { redirect_to products_path, notice: "Produto criado com sucesso." } # Redireciona para o index
        format.json { render :show, status: :created, location: @product }
      else
        #@categories = Category.all
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_dynamic_attributes(attributes)
    return unless attributes.present?
  
    category_id = @product.category_id 
  
    attributes.each do |attribute_id, value|
      @product.product_attribute_category_values.create(
        category_id: category_id,
        category_attribute_id: attribute_id, 
        value: value
      )
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = Product.find(params[:id])
  
    # Preservar imagens existentes
    if params[:product][:existing_images]
      existing_images = params[:product][:existing_images].map { |id| ActiveStorage::Blob.find_signed(id) }
      @product.images.attach(existing_images)
    end
  
    if @product.update(product_params)
      redirect_to @product, notice: 'Produto atualizado com sucesso.'
    else
      render :edit
    end


    # logger.debug "Parameters received for update: #{params.inspect}" # Adiciona log dos parâmetros
  
    # respond_to do |format|
    #   if @product.update(product_params)
    #     logger.debug "Product updated successfully: #{@product.inspect}" # Log de sucesso
    #     format.html { redirect_to @product, notice: "Product was successfully updated." }
    #     format.json { render :show, status: :ok, location: @product }
    #   else
    #     logger.debug "Failed to update product: #{@product.errors.full_messages}" # Log de erro
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product = Product.find(params[:id]) # Busca o produto com base no ID passado
  
    if @product.destroy # Tenta destruir o produto
      respond_to do |format|
        format.html { redirect_to products_path, status: :see_other, notice: "Produto excluído com sucesso." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to products_path, alert: "Erro ao excluir o produto." }
        format.json { render json: { error: "Erro ao excluir o produto." }, status: :unprocessable_entity }
      end
    end
  end

  def destroy_image
    @product = Product.find(params[:id])
    image = @product.images.find(params[:image_id])
    image.purge # Remove a imagem do produto
  
    redirect_to edit_product_path(@product), notice: 'Imagem removida com sucesso.'
  end

  def toggle_active
    @product = Product.find_by(id: params[:id])
  
    if @product.nil?
      redirect_to products_path, alert: 'Produto não encontrado.'
    else
      @product.active = !@product.active
      if @product.save
        redirect_to products_path, notice: 'Status alterado com sucesso.'
      else
        redirect_to products_path, alert: 'Erro ao alterar status do produto.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_categories
      @categories = Category.all # ou o método que você usa para obter as categorias
    end

    # Verificar se o usuário tem permissão para editar ou excluir
    def authorize_user!
      unless current_user.admin? || @product.user == current_user
        redirect_to products_path, alert: "Você não tem permissão para realizar essa ação."
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :priority, :active, :category_id, images: [])
    end
end
