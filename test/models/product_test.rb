require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @store_user = store_users(:drugstore)
    @product = @store_user.products.build(name: "マスク", price: 500,
                           total_num: 100, order_num: 0,
                           store_user_id: @store_user.id)
  end

  test "should be value" do
    assert @product.valid?
  end

  test "user id should be present" do
    @product.store_user_id = nil
    assert_not @product.valid?
  end

  test "name should be present" do
    @product.name = " "
    assert_not @product.valid?
  end

  test "price should be present" do
    @product.price = " "
    assert_not @product.valid?
  end

  test "total_num should be present" do
    @product.total_num = " "
    assert_not @product.valid?
  end

  test "order_num should be present" do
    @product.order_num = " "
    assert_not @product.valid?
  end

  test "name should not be mask or hand soap or sanitizer" do
    @product.name = "トイレペーパー"
    assert_not @product.valid?
  end

  test "price should not be smaller than one" do
    @product.price = 0
    assert_not @product.valid?
    @product.price = -1
    assert_not @product.valid?
  end

  test "price should not be too large" do
    @product.price = 5001
    assert_not @product.valid?
  end

  test "price should be integer" do
    @product.price = 5.2
    assert_not @product.valid?
  end

  test "total_num should not be smaller than one" do
    @product.total_num = 0
    assert_not @product.valid?
    @product.total_num = -1
    assert_not @product.valid?
  end

  test "total_num should be integer" do
    @product.total_num = 5.2
    assert_not @product.valid?
  end

  test "order_num should be integer" do
    @product.order_num = 5.2
    assert_not @product.valid?
  end

  test "order should be most recent first" do
    assert_equal products(:sanitizer), Product.first
  end
end
