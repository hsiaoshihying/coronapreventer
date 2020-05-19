class CustomerUsersController < ApplicationController
  extend AppointmentsHelper
  APPOINTMENTS_FROM = time_from_ago
  APPOINTMENTS_TO = time_now

  def show
    @customer_user = CustomerUser.find(params[:id])
    new_products_from = 15.days.ago.change(hour: 0, min: 0, sec: 0)
    new_products_to = Time.zone.now.change(hour: 23, min: 59, sec: 59)
    @products = Product.where(created_at: new_products_from..new_products_to).paginate(page: params[:page], per_page: 5)
    @appointments = @customer_user.appointments.where(created_at: APPOINTMENTS_FROM..APPOINTMENTS_TO)

  end

  def new
    @customer_user = CustomerUser.new
  end

  def create
    @customer_user = CustomerUser.new(user_params)
    @personal_info = PersonalInfo.find_by(mynumber: @customer_user.mynumber)
    if @personal_info
      message = personal_info_authenticate(@personal_info, @customer_user)
      if @customer_user.save
        log_in @customer_user
        flash[:success] = "登録成功！！買い物はじめよう"
        redirect_to @customer_user
      else
        flash[:danger] = message
        render 'customer_users/new'
      end
    else
      flash[:danger] = "マイナンバーが存在してないです"
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

  def destroy
    CustomerUser.find(params[:id]).destroy
    flash[:success] = "ご利用ありがとうございました！"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:customer_user).permit(:name, :phone, :email,
                                          :password, :password_confirmation,
                                          :address, :mynumber)
  end

  def personal_info_authenticate(personal_info, new_customer_user)
    if (personal_info.address == new_customer_user.address) && (personal_info.name == new_customer_user.name)
      return "身分認証が完成しました"
    elsif (personal_info.address != new_customer_user.address) && (personal_info.name == new_customer_user.name)
      return "住所は本人が登録した情報と違います"
    elsif (personal_info.address == new_customer_user.address) && (personal_info.name != new_customer_user.name)
      return "名前は本人が登録した情報と違います"
    else
      return "名前と住所は本人が登録した情報と違います"
    end
  end
end
