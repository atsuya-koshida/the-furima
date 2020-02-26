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
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @parents = Category.where(ancestry: nil)
      flash.now[:alert] = '出品に失敗しました'
      render :new
    end
  end

  def category_more
    if params[:l_cat]
      @m_cat = Category.find(params[:l_cat]).children
    else
      @s_cat = Category.find(params[:m_cat]).children
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :condition_id, :postage_id, :prefecture_id, :schedule_id, :price, :category_id, images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
