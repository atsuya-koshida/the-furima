class ItemsController < ApplicationController

  def home
  end

  def purchase
  end

  # カテゴリが４の商品を登録が新しい順で10レコード抽出
  def category_index
    @category = Category.where(id: 4)
    @items = Item.where(bought_user_id: nil).where(category_id: 4).order(created_at: "DESC").take(10)
  end

  # 商品検索用のアクション
  def search_index
    if params[:search]
      @search_text = params[:search]
      @items = Item.where(bought_user_id: nil).where("title LIKE ?", "%#{params[:search]}%")
    else
      Item.all
    end
  end
  
end
