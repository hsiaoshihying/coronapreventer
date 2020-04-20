class StoreUsersController < ApplicationController
  def show
    @store_user = StoreUser.find(params[:id])
  end

  def new
    @store_user = StoreUser.new
  end

  def create
    @store_user = StoreUser.new(user_params)
    if @store_user.save
      flash[:success] = "登録成功！！買い物はじめよう"
      redirect_to @store_user
    else
      render 'store_users/new'
    end
  end


  private

  def user_params
    params.require(:store_user).permit(:name, :phone, :address, :email,
                                       :password, :password_confirmation)
  end
end
