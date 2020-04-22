require 'test_helper'

class StoreUsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @store_user = store_users(:drugstore)
  end

  test "unsuccessful edit" do
    get edit_store_user_path(@store_user)
    assert_template 'store_users/edit'
    patch store_user_path(@store_user), params: { store_user: { name:  "",
                                                          phone: "",
                                                          address: "",
                                                          password:              "",
                                                          password_confirmation: ""} }

    assert_template 'store_users/edit'
  end

  test "successful edit" do
    get edit_store_user_path(@store_user)
    assert_template 'store_users/edit'
    name  = "Foo Bar"
    phone = "08012345678"
    address = "123-4567東京都港区芝浦三丁目1番21号"
    patch store_user_path(@store_user), params: { store_user: { name:  name,
                                                                phone: phone,

                                              address: address,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @store_user
    @store_user.reload
    assert_equal name,  @store_user.name
    assert_equal address, @store_user.address
  end
end
