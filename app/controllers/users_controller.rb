class UsersController < ApplicationController
  
  def show
    @address = Address.find_by(user_id: current_user.id)
  end
  
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def info
  end

  def purchaseList
    @bought_items = Item.where(bought_user_id: current_user)
  end

  def exhibitionList
    @selling_items = Item.where(user_id: current_user).where(bought_user_id: nil)
  end

  def soldList
    @sold_items = Item.where(user_id: current_user).where.not(bought_user_id: nil)
  end

  def contact
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :image, :email, :password, :password_confirmation, :lastname, :firstname, :lastname_kana, :firstname_kana, :birthday)
  end
end
