class StoreUsersController < ApplicationController
  def index
    @store_users = StoreUser.paginate(page: params[:page], per_page: 10)
  end

  def show
    @store_user = StoreUser.find(params[:id])
  end


  def new
    @store_user = StoreUser.new
  end

  def create
    @store_user = StoreUser.new(user_params)
    if @store_user.save
      log_in @store_user
      flash[:success] = "登録成功！！買い物はじめよう"
      redirect_to @store_user
    else
      render 'store_users/new'
    end
  end

  def edit
    @store_user = StoreUser.find(params[:id])
  end

  def update
    @store_user = StoreUser.find(params[:id])
    if @store_user.update(user_params)
      flash[:success] = "プロフィール更新された！"
      redirect_to @store_user
    else
      render 'store_users/edit'
    end
  end

  def destroy
    StoreUser.find(params[:id]).destroy
    flash[:success] = "ご利用ありがとうございました！"
    redirect_to root_path
  end

  def products
    # @store_user = StoreUser.find(params[:id])
    # @product = @store_user.products.build if logged_in?
    # @feed_items = @store_user.feed.paginate(page: params[:page])

    if logged_in?
      @product  = current_user.products.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  private

  def user_params
    params.require(:store_user).permit(:name, :phone, :address, :email,
                                       :password, :password_confirmation)
  end
end
