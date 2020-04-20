require 'test_helper'

class StoreUsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @store_user = store_users(:drugstore)
  end

  test "unsuccessful edit" do
    get edit_store_user_path(@store_user)
    assert_template 'store_users/edit'
    patch store_user_path(@store_user), params: { user: { name:  "",
                                                          phone: "",
                                                          address: "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'store_users/edit'
  end
end
