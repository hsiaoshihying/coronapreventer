class InquiriesController < ApplicationController
  def index
    @inquiries = current_user.inquiries.paginate(page: params[:page], per_page: 5)
  end

  def new
    @product = Product.find(params[:product_id])
    @store_user = StoreUser.find(params[:store_user_id])
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = current_user.inquiries.build(inquiry_params)
    if @inquiry.save
      flash[:success] = "質問を送信されました、回答お待ちください"
      redirect_to inquiries_path
    else
      flash[:danger] = "質問の内容を入力してください"
      redirect_to new_inquiry_path(product_id: @inquiry.product_id,
                                   store_user_id: @inquiry.store_user_id)
    end
  end

  def edit
    @inquiry = current_user.inquiries.find(params[:id])
  end

  def update
    @inquiry = Inquiry.find(params[:id])
    if @inquiry.update(inquiry_params)
      if current_user.class.name == "StoreUser"
        flash[:success] = "お客様に回答しました！"
        redirect_to current_user
      else
        flash[:success] = "お店に返信しました！"
        redirect_to inquiries_path
      end
    else
      flash[:danger] = "内容を入力してください"
      redirect_to reply_inquiry_path(@inquiry)
    end
  end


  private

  def inquiry_params
    params.require(:inquiry).permit(:content, :reply, :product_id, :store_user_id)
  end
end
