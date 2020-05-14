require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @store_user = store_users(:drugstore)
    @product = products(:mask)
  end

  test "create product with valid information" do
    log_in_as(@store_user, 'store')
    assert_difference '@store_user.products.count' do
      post products_path, params: { product:{ name:  'マスク', price: 100, total_num: 50 }}
    end

    assert_not flash.empty?
    assert_redirected_to products_store_user_path(@store_user)
  end

  test "create product with invalid information" do
    log_in_as(@store_user, 'store')
    assert_no_difference '@store_user.products.count' do
      post products_path, params: { product:{ name:'  ', price: 6000, total_num: 0 }}
    end
    assert_select 'div#error_explanation'
    assert_template 'store_users/products'
  end

  test "successful edit product" do
    log_in_as(@store_user, 'store')
    get edit_product_path(@product)
    assert_template 'products/edit'
    patch product_path, params: { product:{ name: 'マスク', price: 100, total_num: 50 }}
    assert_redirected_to products_store_user_path(@store_user)
  end

  test "unsuccessful edit product" do
    log_in_as(@store_user, 'store')
    get edit_product_path(@product)
    assert_template 'products/edit'
    patch product_path, params: { product:{ name: '  ', price: 6000, total_num: 0 }}
    assert_template 'products/edit'
  end

  test "delete product" do
    log_in_as(@store_user, 'store')
    assert_difference '@store_user.products.count', -1 do
      delete product_path(@product)
    end
    assert_not flash.empty?
    assert_redirected_to products_store_user_path(@store_user)
  end

end
