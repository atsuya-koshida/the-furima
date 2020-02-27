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
end
