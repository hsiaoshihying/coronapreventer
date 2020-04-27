require 'test_helper'

class StoreUsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @customer_user = customer_users(:michael)
  end

  test "customer access store_index_page" do
    log_in_as(@customer_user, "customer")
    get customer_user_path(@customer_user)
    assert_template 'customer_users/show'
    get store_users_path
    assert_template 'store_users/index'
  end
end
