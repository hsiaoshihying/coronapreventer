require 'test_helper'

class CustomerUsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @customer_user = customer_users(:michael)
  end

  test "unsuccessful edit" do
    get edit_customer_user_path(@customer_user)
    assert_template 'customer_users/edit'
    patch customer_user_path(@customer_user), params: { customer_user: { name:  "",
                                                          phone: "",
                                                          password:              "",
                                                          password_confirmation: "" } }

    assert_template 'customer_users/edit'
  end

  test "successful edit" do
    get edit_customer_user_path(@customer_user)
    assert_template 'customer_users/edit'
    name  = "Foo Bar"
    phone = "07011112222"
    patch customer_user_path(@customer_user), params: { customer_user: { name:  name,
                                                                      phone: phone,
                                                                password:              "",
                                                                password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @customer_user
    @customer_user.reload
    assert_equal name,  @customer_user.name
    assert_equal phone, @customer_user.phone
  end
end
