require "test_helper"

class PlatformTest < ActiveSupport::TestCase
  test "Validate correct platforms" do
    # Platform 1 must be valid with the correct attributes
    platform_1 = platforms(:platform_1)

    assert platform_1.present?
    assert_not_nil platform_1.name
    assert_includes Platform.categories.keys, platform_1.category
    # Platform 2 must be valid with the correct attributes
    platform_2 = platforms(:platform_2)
    assert platform_2.present?
    assert_not_nil platform_2.name
    assert_includes Platform.categories.keys, platform_2.category

    # Platform 3 must be valid with the correct attributes
    platform_3 = platforms(:platform_3)
    assert platform_3.present?
    assert_not_nil platform_3.name
    assert_includes Platform.categories.keys, platform_3.category
  end

  test "Validate that name is required and unique" do
    # skip
    # Unnamed platform must be invalid
    platform = Platform.new(category: 1)
    assert_not platform.valid?
    assert_includes platform.errors.full_messages, "Name can't be blank"

    # Platform with duplicate name must be invalid
    platform_duplicate = Platform.new(name: "Console Platform", category: 1)
    assert_not platform_duplicate.valid?
    assert_includes platform_duplicate.errors.full_messages, "Name has already been taken"
  end

  test "Validate that category is an integer and is within the valid range" do
    # skip
    platform = platforms(:platform_invalid_category_out_of_range)

    assert_not platform.valid?
    assert_includes platform.errors.full_messages,
                    "Category must only contain integer values between 0 and 5"
  end

  test "Validate that category is required" do
    # skip
    platform_without_name = Platform.new(category: 1)

    assert_not platform_without_name.valid?
    assert_includes platform_without_name.errors.full_messages, "Name can't be blank"
  end

  test "Validates relationship has_many: games" do
    game = games :game_1
    game.platforms << platforms(:platform_1)
    game.platforms << platforms(:platform_2)
    game.platforms << platforms(:platform_3)
    assert_equal game.platforms.count, 3
  end
end
