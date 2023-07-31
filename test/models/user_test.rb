require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Content validations User 0 - 5
  test "Validate username and email present" do
    # skip
    user = users(:invalid_user_without_username)
    assert_not user.valid?
    assert_includes user.errors.full_messages, "Username can't be blank"

    user = users(:invalid_user_without_email)
    assert_not user.valid?
    assert_includes user.errors.full_messages, "Email can't be blank"
  end

  test "Validate email format" do
    # skip
    user = users(:invalid_user_by_email_format)
    assert_not user.valid?
    assert_includes user.errors.full_messages, "Email must be a valid email address"
  end

  test "Validate uniqueness of username and email" do
    # skip
    user = users(:valid_user_1)
    duplicate_user = user.dup

    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors.full_messages, "Username has already been taken"
    assert_includes duplicate_user.errors.full_messages, "Email has already been taken"

    duplicate_user.username = "yull123"
    duplicate_user.email = "different_email@example.com"

    assert duplicate_user.valid?
  end

  test "validar edad mínima" do
    user = users(:invalid_user_under_16_years_old)
    assert_not user.valid?
    assert_includes user.errors.full_messages,
                    "Birth date You should be 16 years old to create an account"
    user.birth_date = "2000-01-01"

    assert user.save
  end
end
