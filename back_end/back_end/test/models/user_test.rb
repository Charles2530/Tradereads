require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'valid: user with all valid things' do
    user = User.new(phone: '123123', right:1)
    assert user.valid?
  end

  test 'invalid1: user with invalid phone number' do
    user = User.new(phone: 'a1aa', right:1)
    assert_not user.valid?
  end

  test 'invalid2: user with invalid phone number' do
    user = User.new(phone: '1', right:1)
    assert_not user.valid?
  end
end
