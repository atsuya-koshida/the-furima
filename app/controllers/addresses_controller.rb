class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save                    # ←保存処理がうまくいったかどうかの判定
      redirect_to user_path(current_user.id)#, notice: '住所を編集しました'
    else
      render :new   #「render」はコントローラを経由しないため元のインスタンス変数の値が上書きされない。
    end
  end

  def edit
    @address = Address.find_by(user_id: params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to user_path(current_user.id), notice: '住所登録を更新しました'
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:lastname,
                                    :firstname, 
                                    :lastname_kana, 
                                    :firstname_kana,
                                    :postal_code,
                                    :prefecture,
                                    :city,
                                    :house_num,
                                    :detail,
                                    :tel_num).merge(user_id: current_user.id)
  end
end
