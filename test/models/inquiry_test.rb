require 'test_helper'

class InquiryTest < ActiveSupport::TestCase
  def setup
    @customer_user = customer_users(:michael)
    @store_user = store_users(:drugstore)
    @product = products(:mask)
    @inquiry = @customer_user.inquiries.build(content:"マスクの大きさを伺いたいです",
                                              # reply: "小さめ",
                                              store_user_id: @store_user.id,
                                              product_id: @product.id)
  end

  test "should be valid" do
    assert @inquiry.valid?
  end

  test "content should be presence" do
    @inquiry.content = " "
    assert_not @inquiry.valid?
  end

  test "reply should be presence" do
    @inquiry.reply = " "
    assert_not @inquiry.valid?
  end

  test "content should not be too long" do
    @inquiry.content = "a" * 301
    assert_not @inquiry.valid?
  end

  test "reply should not be too long" do
    @inquiry.reply = "a" * 301
    assert_not @inquiry.valid?
  end
end
