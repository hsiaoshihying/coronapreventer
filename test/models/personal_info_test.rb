require 'test_helper'

class PersonalInfoTest < ActiveSupport::TestCase
  def setup
    @personal_info = PersonalInfo.new(mynumber: "123456789012",
                                      name: "michael",
                                      address: "108-0014東京都港区芝浦三丁目1番21号")
  end

  test "should be valid" do
    @personal_info.valid?
  end

  test "mynumber should be present" do
    @personal_info.mynumber = " "
    assert_not @personal_info.valid?
  end

  test "name should be present" do
    @personal_info.name = " "
    assert_not @personal_info.valid?
  end

  test "address should be present" do
    @personal_info.address = " "
    assert_not @personal_info.valid?
  end

  test "mynumber validation should reject invalid input" do
    invalid_mynumbers = %w(0123456789123 01234567891 0123.4566 abcdefg)
    invalid_mynumbers.each do |invalid_mynumber|
      @personal_info.mynumber = invalid_mynumber
      assert_not @personal_info.valid?
    end
  end

  test"name should not be too long" do
    @personal_info.name = 'a'*51
    assert_not @personal_info.valid?
  end

  test "address validation should reject invalid address" do
    invalid_addresses = %w(東京都港区芝浦三丁目1番21号 東京都 港区 108-0014東京都港区 108-000東京都港区芝浦三丁目1番21号)
    invalid_addresses.each do |invalid_address|
      @personal_info.address = invalid_address
      assert_not @personal_info.valid?
    end
  end

end
