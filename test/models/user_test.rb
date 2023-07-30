require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "Yull1234",
      email: "yull@gmail.com",
      birth_date: "2000-01-01"
    )
  end

  test "Test" do
    puts @user.save
  end
end
