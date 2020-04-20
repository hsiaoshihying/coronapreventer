require 'test_helper'

class CustomerUsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get customer_signup_path
    assert_no_difference 'CustomerUser.count' do
      post customer_users_path, params: { customer_user: { name:  "",
                                                     phone: "1234",
                                                     email: "user@invalid",
                                                     password:              "foo",
                                                     password_confirmation: "bar" } }
    end
    assert_template 'customer_users/new'
  end

  test "valid signup information" do
    get customer_signup_path
    assert_difference 'CustomerUser.count', 1 do
      post customer_signup_path, params: { customer_user: { name:  "Example User",
                                                      phone: "08012345678",
                                                      email: "user@example.com",
                                                      password:              "password",
                                                      password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'customer_users/show'
  end
end
