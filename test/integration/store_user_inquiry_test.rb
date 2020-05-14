require 'test_helper'

class StoreUserInquiryTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:mask)
    @store_user = store_users(:drugstore)
    @inquiry = inquiries(:question_one)
  end

  test "count of records on mypage are correct" do
    log_in_as(@store_user, 'store')
    assert_redirected_to store_user_path(@store_user)
    follow_redirect!
    assert_select "dl", @store_user.inquiries.count
  end

  test"successfully reply the question from customer" do
    log_in_as(@store_user, 'store')
    get reply_inquiry_path(@inquiry)
    assert_select 'label', "回答"
    assert_template 'inquiries/edit'
    patch reply_update_inquiry_path, params: { inquiry: { reply: "大きさは",
                                                          content: @inquiry.content,
                                                          store_user_id: @store_user.id,
                                                          product_id: @product.id}}
    assert_redirected_to store_user_path(@store_user)
    follow_redirect!
    assert_select 'div.alert.alert-success'
  end

  test"unsuccessfully reply the question from customer" do
    log_in_as(@store_user, 'store')
    get reply_inquiry_path(@inquiry)
    assert_select 'label', "回答"
    assert_template 'inquiries/edit'
    patch reply_update_inquiry_path, params: { inquiry: { reply: "　",
                                                          content: @inquiry.content,
                                                          store_user_id: @store_user.id,
                                                          product_id: @product.id}}
    assert_redirected_to reply_inquiry_path(@inquiry)
    follow_redirect!
    assert_select 'div.alert.alert-danger'
  end

end
