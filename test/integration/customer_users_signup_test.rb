require 'test_helper'

class CustomerUsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get customer_signup_path
    assert_no_difference 'CustomerUser.count' do
      post customer_users_path, params: { customer_user: { name:  "",
                                                     phone: "1234",
                                                     email: "user@invalid",
                                                     address: " ",
                                                     mynumber: " ",
                                                     password:              "foo",
                                                     password_confirmation: "bar" } }
    end
    assert_template 'customer_users/new'
    assert_select 'div.alert.alert-danger'
  end

  # test "valid signup information" do
  #   get customer_signup_path
  #   name = "小林 瑛太"
  #   address = "108-0014東京都港区芝浦三丁目1番21号"
  #   mynumber = "265615957710"
  #   assert_difference 'CustomerUser.count' do
  #     post customer_signup_path, params: { customer_user: { name:  name,
  #                                                     phone: "08012345678",
  #                                                     email: "user@example.com",
  #                                                     address: address,
  #                                                     mynumber: mynumber,
  #                                                     password:              "foobar",
  #                                                     password_confirmation: "foobar" } }
  #   end
  #   follow_redirect!
  #   assert_template 'customer_users/show'
  #   assert is_logged_in?
  # end
end
