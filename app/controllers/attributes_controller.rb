class AttributesController < ApplicationController
  before_action :set_attribute, only: %i[ show edit update destroy ]

  # GET /attributes or /attributes.json
  def index
    @per_page = 6 
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @attributes = Attribute.limit(@per_page).offset((@page - 1) * @per_page)   
    @total_attributes = Attribute.count
    @total_pages = (@total_attributes / @per_page.to_f).ceil
  end

  # GET /attributes/1 or /attributes/1.json
  def show
    @attribute = Attribute.find(params[:id])
  end

  # GET /attributes/new
  def new
    @attribute = Attribute.new
  end

  # GET /attributes/1/edit
  def edit
    @attribute = Attribute.find(params[:id])
  end

  # POST /attributes or /attributes.json
  def create
    @attribute = Attribute.new(attribute_params)
  
    respond_to do |format|
      if @attribute.save
        format.html { redirect_to attributes_path(locale: I18n.locale), notice: "Atributo foi criado com sucesso." }
        format.json { render :show, status: :created, location: @attribute }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attributes/1 or /attributes/1.json
  def update
    respond_to do |format|
      if @attribute.update(attribute_params)
        format.html { redirect_to @attribute, notice: "Atributo alterado com sucesso." }
        format.json { render :show, status: :ok, location: @attribute }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attributes/1 or /attributes/1.json
  def destroy
    @attribute.destroy!

    respond_to do |format|
      format.html { redirect_to attributes_path, status: :see_other, notice: "Atributo excluido com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_attribute
      @attribute = Attribute.find(params[:id])
    end

    def attribute_params
      params.require(:attribute).permit(:description, :domain)
    end
end
