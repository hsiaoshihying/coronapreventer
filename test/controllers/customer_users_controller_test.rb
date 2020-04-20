require 'test_helper'

class CustomerUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_customer_user_path
    assert_response :success
  end

end
