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
      log_in @customer_user
      flash[:success] = "登録成功！！買い物はじめよう"
      redirect_to @customer_user
    else
      render 'customer_users/new'
    end
  end

  def edit
    @customer_user = CustomerUser.find(params[:id])
  end

  def update
    @customer_user = CustomerUser.find(params[:id])
    if @customer_user.update(user_params)
      flash[:success] = "プロフィール更新された！"
      redirect_to @customer_user
    else
      render 'customer_users/edit'
    end
  end

  # def destroy
  #   CustomerUser.find(params[:id]).destroy
  #   flash[:success] = "ご利用ありがとうございました！"
  #   redirect_to root_path
  # end

  private

  def user_params
    params.require(:customer_user).permit(:name, :phone, :email,
                                       :password, :password_confirmation)
  end
end
