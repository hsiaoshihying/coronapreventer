require 'test_helper'

class StoreUserTest < ActiveSupport::TestCase
  def setup
    @store_user = StoreUser.new(name: "Example Store", phone: "0312345678",
                                address: "108-0014東京都港区芝浦三丁目1番21号", email: "user@example.com",
                                password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @store_user.valid?
  end

  test "name should be present" do
    @store_user.name = " "
    assert_not @store_user.valid?
  end

  test "phone should be present" do
    @store_user.phone = " "
    assert_not @store_user.valid?
  end

  test "address should be present" do
    @store_user.address = " "
    assert_not @store_user.valid?
  end

  test "email should be present" do
    @store_user.email = " "
    assert_not @store_user.valid?
  end

  test "password should be present" do
    @store_user.password = @store_user.password_confirmation = " "*6
    assert_not @store_user.valid?
  end

  test "name should not be too long" do
    @store_user.name = "a"*51
    assert_not @store_user.valid?
  end

  test "email should not be too long" do
    @store_user.email = "a" * 244 + "@example.com"
    assert_not @store_user.valid?
  end

  test "password should have a minimum length" do
    @store_user.password = @store_user.password_confirmation = "a" * 5
    assert_not @store_user.valid?
  end

  test "phone validation should reject invalid phone number" do
    invalid_phone_numbers = %w[031234567, a31234567, 0701234567a, 070123456789]
    invalid_phone_numbers.each do |invalid_phone_number|
      @store_user.phone = invalid_phone_number
      assert_not @store_user.valid?

    end
  end

  test "address validation should reject invalid address" do
    invalid_addresses = %w[東京都港区芝浦三丁目1番21号, 東京都, 港区, 108-0014東京都港区]
    invalid_addresses.each do |invalid_address|
      @store_user.address = invalid_address
      assert_not @store_user.valid?
    end
  end

  test "email validation should reject invalid email addresses" do
    invalid_email_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_email_addresses.each do |invalid_email_address|
      @store_user.email = invalid_email_address
      assert_not @store_user.valid?, "#{invalid_email_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_store_user = @store_user.dup
    duplicate_store_user.email = @store_user.email.upcase
    @store_user.save
    assert_not duplicate_store_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @store_user.email = mixed_case_email
    @store_user.save
    assert_equal mixed_case_email.downcase, @store_user.reload.email
  end

  test "associated products should be destroyed along with destroying store user" do
    @store_user.save
    @store_user.products.create!(name: "mask", price: 500, total_num: 100)
    assert_difference 'Product.count', -1 do
      @store_user.destroy
    end
  end
end
