class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
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
        format.html { redirect_to category_path(@category, locale: I18n.locale), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    @category = Category.find(params[:id])
    puts "Antes de atualizar: #{@category.inspect}"
  
    if @category.update(category_params)
      puts "Atualização bem-sucedida: #{@category.inspect}"
      redirect_to @category, notice: 'Categoria atualizada com sucesso.'
    else
      puts "Erro ao atualizar: #{@category.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, status: :see_other, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def manage_attributes
    @category = Category.find(params[:id]) # Carrega a categoria pelo id
    @available_attributes = Attribute.where.not(id: @category.custom_attributes.ids)
    @category_attributes = @category.custom_attributes
  end

  def update_attributes
    @category = Category.find(params[:id])

    attribute_ids = params[:attribute_ids].reject(&:blank?)  # Remove IDs em branco
  
    @category.attribute_ids = attribute_ids
    
    if @category.save
      redirect_to categories_path(locale: I18n.locale), notice: 'Attributes were successfully updated.'
    else
      @available_attributes = Attribute.where.not(id: @category.attribute_ids)
      @category_attributes = @category.attributes
      render :manage_attributes
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:description, :parent_id, attribute_ids: [])
    end
end
