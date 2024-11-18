class StoreController < ApplicationController
  def index
    @categories = Category.main_categories.includes(:children)
    # @categories = Category.main_categories.includes(:subcategories)
  end
end