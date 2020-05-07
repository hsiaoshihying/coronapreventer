require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  def setup
    @customer = customer_users(:michael)
    @product = products(:one)
    @store = @product.store_user
    @appointment = @customer.appointments.build(store_user_id: @store.id,
                                                product_id: @product.id,
                                                product_name: @product.name)
  end

  test "should be valid" do
    assert @appointment.valid?
  end

  test "customer id should be present" do
    @appointment.customer_user_id = nil
    assert_not @appointment.valid?
  end

  test "store id should be present" do
    @appointment.store_user_id = nil
    assert_not @appointment.valid?
  end

  test "product id should be present" do
    @appointment.product_id = nil
    assert_not @appointment.valid?
  end

  test "product name should be present" do
    @appointment.product_name = nil
    assert_not @appointment.valid?
  end
end
