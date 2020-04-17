require 'test_helper'

class CustomerUserTest < ActiveSupport::TestCase
  def setup
    @customer_user = CustomerUser.new(name: "Example Customer", phone: "07012345678", email: "user@example.com",
                                password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @customer_user.valid?
  end

  test "name should be present" do
    @customer_user.name = " "
    assert_not @customer_user.valid?
  end

  test "phone should be present" do
    @customer_user.phone = " "
    assert_not @customer_user.valid?
  end

  test "email should be present" do
    @customer_user.email = " "
    assert_not @customer_user.valid?
  end

  test "password should be present" do
    @customer_user.password = @customer_user.password_confirmation = " "*6
    assert_not @customer_user.valid?
  end

  test "name should not be too long" do
    @customer_user.name = "a"*51
    assert_not @customer_user.valid?
  end

  test "email should not be too long" do
    @customer_user.email = "a" * 244 + "@example.com"
    assert_not @customer_user.valid?
  end

  test "password should have a minimum length" do
    @customer_user.password = @customer_user.password_confirmation = "a" * 5
    assert_not @customer_user.valid?
  end

  test "phone validation should reject invalid phone number" do
    invalid_phone_numbers = %w[031234567, a31234567, 0701234567a, 070123456789]
    invalid_phone_numbers.each do |invalid_phone_number|
      @customer_user.phone = invalid_phone_number
      assert_not @customer_user.valid?
    end
  end

  test "email validation should reject invalid email addresses" do
    invalid_email_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_email_addresses.each do |invalid_email_address|
      @customer_user.email = invalid_email_address
      assert_not @customer_user.valid?, "#{invalid_email_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_store_user = @customer_user.dup
    duplicate_store_user.email = @customer_user.email.upcase
    @customer_user.save
    assert_not duplicate_store_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @customer_user.email = mixed_case_email
    @customer_user.save
    assert_equal mixed_case_email.downcase, @customer_user.reload.email
  end
end
