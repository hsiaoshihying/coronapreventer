# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def products_arrived
    user = CustomerUser.first
    product = Product.order("created_at").first
    UserMailer.products_arrived(user, product)
  end
end
