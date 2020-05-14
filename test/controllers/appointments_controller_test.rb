require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @customer = customer_users(:michael)
    @appointment = appointments(:one)
    @product = products(:mask)
    @store = @product.store_user
  end

  test "customer successfully creates an appointment" do
    log_in_as(@customer, 'customer')
    get store_users_path
    assert_template 'store_users/index'
    assert_difference 'Appointment.count' do
      post appointments_path(store_user_id: @store, product_id: @product, product_name: @product.name )
    end
    assert_not flash.empty?
    assert_redirected_to store_users_path
  end

end
