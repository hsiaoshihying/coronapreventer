class AppointmentsController < ApplicationController

  def create
    store_user_id = params[:store_user_id]
    product_id = params[:product_id]
    product_name = params[:product_name]
    @appointment = current_user.appointments.build(store_user_id: store_user_id,
                                                   product_id: product_id,
                                                   product_name: product_name)
    if @appointment.save
      order_num = @appointment.product.order_num + 1
      @product = @appointment.product.update(order_num: order_num )
      flash[:success] = "商品を予約しました!"
      redirect_to store_users_path
    else
      flash[:danger] = "商品の予約が失敗!"
      redirect_to store_users_path
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    order_num = @appointment.product.order_num - 1
    @product = @appointment.product.update(order_num: order_num )
    @appointment.destroy
    flash[:success] = "予約が削除されました！"
    redirect_to request.referrer || customer_users_path(current_user)
  end

  private

  def appointment_params
    params.require(:appointment).permit(:store_user_id, :product_id)
  end

  def correct_user
    @appointment = current_user.appointments.find_by(id: params[:id])
    redirect_to appointments_path if @appointment.nil?
  end
end
