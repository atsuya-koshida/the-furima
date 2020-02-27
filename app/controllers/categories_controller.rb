class CategoriesController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil)
  end

  def itemsindex
  end
  
end
