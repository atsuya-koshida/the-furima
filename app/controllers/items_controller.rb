class ItemsController < ApplicationController

  def home
  end

  def purchase
  end

  def new
    @item = Item.new
    @item.images.new
    @parents = Category.where(ancestry: nil)
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @parents = Category.where(ancestry: nil)
      @item = Item.new(item_params)
      @item.images.new
      render :new
      # flash.now[:alert] = '出品に失敗しました'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :condition_id, :postage_id, :prefecture_id, :schedule_id, :price, :category_id, images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
