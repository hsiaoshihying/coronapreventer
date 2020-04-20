require 'test_helper'

class StoreUsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get store_signup_path
    assert_no_difference 'StoreUser.count' do
      post store_users_path, params: { store_user: { name:  "",
                                                phone: "",
                                                address: "144-1234",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'store_users/new'
  end

  test "valid signup information" do
    get store_signup_path
    assert_difference 'StoreUser.count', 1 do
      post store_signup_path, params: { store_user: { name:  "Example User",
                                                      phone: "08012345678",
                                         address: "108-0014東京都港区芝浦三丁目1番21号",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'store_users/show'
    assert is_logged_in?
  end
end
