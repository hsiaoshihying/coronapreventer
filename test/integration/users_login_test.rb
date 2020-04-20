require 'test_helper'

def setup
  @store_user = store_users(:DrugStore)
  # @customer_user = customer_users(:michael)
end

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "store login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {user: "store", email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "customer login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {user: "customer", email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with no choosing store/customer" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "store login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { user: "store",
                                          email:    @store_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @store_user
    follow_redirect!
    assert_template 'store_user/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", store_user_path(@store_user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", store_user_path(@store_user), count: 0
  end

  # test "customer login with valid information followed by logout" do
  #   get login_path
  #   post login_path, params: { session: { user: "customer",
  #                                         email:    @customer_user.email,
  #                                         password: 'password' } }
  #   assert_redirected_to @customer_user
  #   follow_redirect!
  #   assert_template 'customer_users/show'
  #   assert_select "a[href=?]", login_path, count: 0
  #   assert_select "a[href=?]", logout_path
  #   assert_select "a[href=?]", customer_user_path(@customer_user)
  # end
end
