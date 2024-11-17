class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @page = params[:page].present? ? params[:page].to_i : 1
    @per_page = 6
  
    # Filtros
    categories_scope = Category.includes(:parent)
    categories_scope = categories_scope.where("description ILIKE ?", "%#{params[:description]}%") if params[:description].present?
    categories_scope = categories_scope.where(parent_id: params[:parent_id]) if params[:parent_id].present?
  
    # Paginação
    @total_categories = categories_scope.count
    @total_pages = (@total_categories.zero? ? 1 : (@total_categories / @per_page.to_f).ceil)
    @categories = categories_scope.offset((@page - 1) * @per_page).limit(@per_page)
  
    @parent_categories = Category.where(parent_id: nil) # Para o filtro de categorias pai
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.find(params[:id])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
  
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path(locale: I18n.locale), notice: "Categoria criada com sucesso." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Categoria alterada com sucesso." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    if @category.destroy
      redirect_to categories_path, notice: 'Categoria excluída com sucesso.'
    else
      redirect_to categories_path, alert: @category.errors.full_messages.to_sentence
    end
  end

  def manage_attributes
    @category = Category.find(params[:id]) 
    @available_attributes = Attribute.where.not(id: @category.custom_attributes.ids)
    @category_attributes = @category.custom_attributes
  end

  def update_attributes
    @category = Category.find(params[:id])

    if params[:category].present? && params[:category][:attribute_ids].present?
      attribute_ids = params[:category][:attribute_ids].reject(&:blank?)
  
      @category.custom_attributes = Attribute.where(id: attribute_ids)
  
      if @category.save
        redirect_to categories_path(locale: I18n.locale), notice: 'Editado com sucesso.'
      else
        render :edit, alert: 'Erro ao editar.'
      end
    else
      redirect_to categories_path(locale: I18n.locale), alert: 'Atributo não selecionado.'
    end
  end

  # def attributes
  #   @attributes = Category.find(params[:id]).attributes
  #   render json: @attributes
  # end

  def attributes
    category = Category.find(params[:id])
    attributes = category.custom_attributes  # Isso assume que a relação está correta
    
    render json: attributes.map { |attribute| 
      { 
        id: attribute.id, 
        description: attribute.description, 
        type: attribute.domain  # Alterado para usar o campo 'domain'
      }
    }
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:description, :parent_id, attribute_ids: [])
    end
end
