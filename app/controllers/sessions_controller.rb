class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:user] == "store"
      user = StoreUser.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to user
      else
        flash.now[:danger] = 'メールアドレスまたはパスワードが有効ではありません' # 本当は正しくない
        render 'new'
      end
    elsif params[:session][:user] == "customer"
      user = CustomerUser.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to user
      else
        flash.now[:danger] = 'メールアドレスまたはパスワードが有効ではありません' # 本当は正しくない
        render 'new'
      end
    else
      flash.now[:danger] = 'ドラッグストア・消費者を選んでください'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
