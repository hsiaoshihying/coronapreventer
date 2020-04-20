class CustomerUsersController < ApplicationController
  def show
    @customer_user = CustomerUser.find(params[:id])
  end

  def new
    @customer_user = CustomerUser.new
  end

  def create
    @customer_user = CustomerUser.new(user_params)
    if @customer_user.save
      flash[:success] = "登録成功！！買い物はじめよう"
      redirect_to @customer_user
    else
      render 'customer_users/new'
    end
  end

  private

  def user_params
    params.require(:customer_user).permit(:name, :phone, :email,
                                       :password, :password_confirmation)
  end
end
