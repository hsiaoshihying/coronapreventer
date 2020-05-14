require 'test_helper'

class CustomerUserInquiryTest < ActionDispatch::IntegrationTest
  def setup
    @customer_user = customer_users(:michael)
    @product = products(:mask)
    @store_user = store_users(:drugstore)
    @inquiry = inquiries(:question_one)
  end

  test "successfully creates new inquiry" do
    log_in_as(@customer_user, 'customer')
    get store_users_path
    assert_template 'store_users/index'
    get new_inquiry_path(store_user_id: @store_user.id,
                         product_id: @product.id)
    assert_template 'inquiries/new'
    assert_select 'label', "質問"
    post inquiries_path, params: { inquiry: { content: "容量がどのくらいですか",
                                              store_user_id: @store_user.id,
                                              product_id: @product.id}}
    assert_not flash.empty?
    assert_redirected_to inquiries_path
    follow_redirect!
    assert_select 'div.alert.alert-success'
  end

  test "unsuccessfully creates new inquiry" do
    log_in_as(@customer_user, 'customer')
    get store_users_path
    assert_template 'store_users/index'
    get new_inquiry_path(store_user_id: @store_user.id,
                         product_id: @product.id)
    assert_template 'inquiries/new'
    assert_select 'label', "質問"
    post inquiries_path, params: { inquiry: { content: " ",
                                              store_user_id: @store_user.id,
                                              product_id: @product.id}}
    assert_not flash.empty?
    assert_redirected_to new_inquiry_path(store_user_id: @store_user.id,
                                          product_id: @product.id)
    follow_redirect!
    assert_select 'div.alert.alert-danger'
  end

  test "successfully reply the answer from store" do
    log_in_as(@customer_user, 'customer')
    get inquiries_path
    assert_template 'inquiries/index'
    get reply_inquiry_path(@inquiry)
    assert_template 'inquiries/edit'
    assert_select 'label', "返信"
    patch reply_update_inquiry_path, params: { inquiry: { content: "new content",
                                                          store_user_id: @store_user.id,
                                                          product_id: @product.id}}
    assert_not flash.empty?
    assert_redirected_to inquiries_path
    follow_redirect!
    assert_select 'div.alert.alert-success'
  end

  test "unsuccessfully reply the answer from store" do
    log_in_as(@customer_user, 'customer')
    get inquiries_path
    assert_template 'inquiries/index'
    get reply_inquiry_path(@inquiry)
    assert_template 'inquiries/edit'
    assert_select 'label', "返信"
    patch reply_update_inquiry_path, params: { inquiry: { content: " ",
                                                          store_user_id: @store_user.id,
                                                          product_id: @product.id}}
    assert_redirected_to reply_inquiry_path(@inquiry)
    follow_redirect!
    assert_select 'div.alert.alert-danger'
  end

  test "the records on the all inquiries page are correct" do
    log_in_as(@customer_user, 'customer')
    get inquiries_path
    assert_template 'inquiries/index'
    assert_select "dl", @customer_user.inquiries.count
  end
end
