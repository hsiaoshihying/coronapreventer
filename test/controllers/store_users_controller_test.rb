require 'test_helper'

class StoreUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_store_user_path
    assert_response :success
  end

end
