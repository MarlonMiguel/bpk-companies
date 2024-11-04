class StoreController < ApplicationController
  def index
    @categories = Category.main_categories.includes(:children)
  end
end