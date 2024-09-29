class HomeController < ApplicationController
  def index
    @categories = Category.includes(:subcategories).where(parent_id: nil)
  end
end