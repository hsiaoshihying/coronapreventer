class PasswordResetsController < ApplicationController
  def new
  end

  # def create
  #   if params[:password_reset][:user] == 'store'
  #     @user = StoreUser.find_by(email: params[:password_reset][:email].downcase)
  #   elsif params[:password_reset][:user] == 'customer'
  #     @user = CustomerUser.find_by(email: params[:password_reset][:email].downcase)
  #   else
  #     flash.now[:danger] = 'ドラッグストア・消費者を選んでください'
  #     render 'new'
  #   end
  #
  #   if @user
  #     @user.create_reset_digest
  #     @user.send_password_reset_email
  #     flash[:info] = "Email sent with password reset instructions"
  #     redirect_to root_url
  #   else
  #     flash.now[:danger] = "Email address not found"
  #     render 'new'
  #   end
  # end

  def edit
  end
end
