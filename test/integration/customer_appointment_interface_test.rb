require 'test_helper'

class CustomerInquiryInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @customer_user = customer_users(:michael)
    @store_user = store_users(:drugstore)
    @appointment_1 = appointments(:one)
    @appointment_2 = appointments(:two)
    @appointment_3 = appointments(:three)
  end

  test "reserve one product" do
    log_in_as(@customer_user, 'customer')
    get store_users_path
    assert_template 'store_users/index'
    post appointments_path(store_user_id: @appointment_1.store_user,
                          product_id: @appointment_1.product,
                          product_name: @appointment_1.product_name)
    assert_redirected_to store_users_path
    follow_redirect!
    assert_select 'div.alert.alert-success'
  end

  test "reserve three products in one month" do
    log_in_as(@customer_user, 'customer')
    get store_users_path
    assert_template 'store_users/index'
    post appointments_path(store_user_id: @appointment_1.store_user,
                           product_id: @appointment_1.product,
                           product_name: @appointment_1.product_name)
    assert_redirected_to store_users_path
    follow_redirect!
    assert_select 'div.alert.alert-success'
    post appointments_path(store_user_id: @appointment_2.store_user,
                           product_id: @appointment_2.product,
                           product_name: @appointment_2.product_name)
    assert_redirected_to store_users_path
    follow_redirect!
    assert_select 'div.alert.alert-success'
    post appointments_path(store_user_id: @appointment_3.store_user,
                           product_id: @appointment_3.product,
                           product_name: @appointment_3.product_name)
    assert_redirected_to store_users_path
    follow_redirect!
    assert_select 'div.alert.alert-warning.alert-dismissible'
  end
end
