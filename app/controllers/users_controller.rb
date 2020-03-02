class UsersController < ApplicationController
  before_action :set_card, only: [:show, :indo, :purchaseList, :exhibitionList, :soldList, :contact]
  before_action :set_address, only: [:show, :indo, :purchaseList, :exhibitionList, :soldList, :contact]
  
  def show
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
  end

  def exhibitionList
  end

  def soldList
  end

  def contact
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :image, :email, :password, :password_confirmation, :lastname, :firstname, :lastname_kana, :firstname_kana, :birthday)
  end

  def set_card
    @card = Card.find_by(user_id: current_user)
  end

  def set_address
    @address = Address.find_by(user_id: current_user.id)
  end
end
