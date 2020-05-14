require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "products_arrived" do
    user = customer_users(:michael)
    product = products(:sanitizer)
    mail = UserMailer.products_arrived(user, product)
    assert_equal "新商品が入荷された！", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,               mail.text_part.body.to_s.encode("UTF-8")
    assert_match product.store_user.name,   mail.text_part.body.to_s.encode("UTF-8")
    assert_match product.name, mail.text_part.body.to_s.encode("UTF-8")
    assert_match product.price.to_s, mail.text_part.body.to_s.encode("UTF-8")
    assert_match product.total_num.to_s, mail.text_part.body.to_s.encode("UTF-8")
  end


end
