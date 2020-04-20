require 'test_helper'

class CustomerUsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @customer_user = customer_users(:michael)
  end

  test "unsuccessful edit" do
    get edit_customer_user_path(@customer_user)
    assert_template 'customer_users/edit'
    patch customer_user_path(@customer_user), params: { user: { name:  "",
                                                          phone: "",
                                                          email: "foo@invalid",
                                                          password:              "foo",
                                                          password_confirmation: "bar" } }

    assert_template 'customer_users/edit'
  end
end
