class HomeController < ApplicationController
  def index
    @categories = Category.all # ou outra lógica para carregar suas categorias
    @products = Product.all
  end
end