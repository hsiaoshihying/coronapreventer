class ProductsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = "商品が追加された!"
      redirect_to products_store_user_path(current_user)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'store_users/products'
    end
  end

  def edit
    @product = current_user.products.find_by(id: params[:id])
  end

  def update
    @product = current_user.products.find_by(id: params[:id])
    if @product.update(product_params)
      flash[:success] = "商品情報が更新された！"
      redirect_to products_store_user_path(current_user)
    else
      render 'products/edit'
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "商品が削除されました！"
    redirect_to request.referrer || products_store_user_path(current_user)
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :total_num, :order_num)
  end

  def correct_user
    @product = current_user.products.find_by(id: params[:id])
    redirect_to products_store_user_path(current_user) if @product.nil?
  end
end
