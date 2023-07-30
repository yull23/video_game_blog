require "test_helper"

class CriticTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "Yull1234",
      email: "yull@gmail.com",
      birth_date: "2000-01-01"
    )
    @game=
  end
end
