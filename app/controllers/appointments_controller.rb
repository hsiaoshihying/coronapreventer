class AppointmentsController < ApplicationController
  def index

  end

  def create
    product_id = params[product_id]
    store_user_id = params[store_user_id]
    @appointment = current_user.appointments.build(store_user_id:store_user_id, product_id:product_id)
    if @appointment.save
      flash[:success] = "商品を予約しました!"
      redirect_to store_users_path
    else
      puts params[:content]
      puts product_id
      puts store_user_id
      puts @appointment.errors.full_messages
      flash[:success] = "商品の予約が失敗!"
      redirect_to store_users_path
    end
  end

  def destroy

  end

  private

  def appointment_params
    params.require(:appointmnet).permit(:store_user_id, :product_id)
  end

  def correct_user
    @appointment = current_user.appointments.find_by(id: params[:id])
    redirect_to appointments_path if @appointment.nil?
  end
end
