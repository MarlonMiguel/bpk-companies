class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[ edit update destroy ]

  # GET /products or /products.json
  def index
    if current_user.admin?  
      @products = Product.all  
    else
      @products = current_user.products  
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.all # Carregue as categorias para o select
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all # Carregue as categorias para o select
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_image
    @product = Product.find(params[:id])
    image = @product.images.find(params[:image_id]) # Aqui usamos o image_id para buscar a imagem
    image.purge # Remove a imagem do ActiveStorage
  
    respond_to do |format|
      format.html { redirect_to @product, notice: "Imagem foi excluída com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Verificar se o usuário tem permissão para editar ou excluir
    def authorize_user!
      unless current_user.admin? || @product.user == current_user
        redirect_to products_path, alert: "Você não tem permissão para realizar essa ação."
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :priority, :active, :category_id, images: [])
    end
end
