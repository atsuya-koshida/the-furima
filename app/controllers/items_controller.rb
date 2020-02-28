class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :purchase, :pay, :done]
  before_action :set_card, only: [:purchase, :pay, :done]
  before_action :authenticate_user!, only: [:purchase, :pay, :done]

  def home

    @roots_cat = []
    @items = []
    roots = Category.where(ancestry: nil)
    3.times do |count|
      @roots_cat.push(roots[count]) # TODO:ランダム
      @items.push(Item.where(bought_user_id: nil).where(category_id: @roots_cat[count].indirect_ids).order(created_at: "DESC").take(10))
    end
    
  end

  def show
    @user = User.find(@item.user_id)
    @category = Category.find(@item.category_id)
    @images =Image.find_by(item_id: params[:id])
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

  def purchase
    @address = Address.find_by(user_id: current_user)
    if @card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => @card.customer_id,
    :currency => 'jpy'
    )
    Item.update(bought_user_id: current_user.id)
    redirect_to action: 'done' 
  end

  def done
    @address = Address.find_by(user_id: current_user)
    @user = User.find_by(id: @item.user_id)
    @category = Category.find_by(id: @item.category_id)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :condition_id, :postage_id, :prefecture_id, :schedule_id, :price, :category_id, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_card
    @card = Card.find_by(user_id: current_user)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
