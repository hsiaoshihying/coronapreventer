class UserMailer < ApplicationMailer
  def products_arrived(user, product)
    @user = user
    @product = product
    mail to: user.email, subject: "新商品が入荷された！"
  end

  def send_to_all_customer_users(product)
    @users = CustomerUser.all
    @product = product
    @users.each do |user|
      UserMailer.products_arrived(user, product).deliver_now
    end
  end
end
