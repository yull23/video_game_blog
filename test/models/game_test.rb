require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "Validate correct games" do
    # skip
    game_1 = games(:game_1)
    assert game_1.valid?
    assert_not_nil game_1.name
    assert_includes Game.categories.keys, game_1.category

    game_2 = games(:game_2)
    assert game_2.valid?
    assert_not_nil game_2.name
    assert_includes Game.categories.keys, game_2.category

    game_3 = games(:game_3)
    assert game_3.valid?
    assert_not_nil game_3.name
    assert_includes Game.categories.keys, game_3.category

    game_4 = Game.create(
      name: "The Legend of Zelda: Breath of the Wild - Expansion Pack",
      category: 1,
      rating: 88,
      parent: game_1
    )
    assert game_4.valid?
    assert_not_nil game_4.name
    assert_includes Game.categories.keys, game_4.category
    assert_equal "main_game", game_4.parent.category

    game_5 = Game.create(
      name: "Super Mario Odyssey - Expansion Pack",
      category: 1,
      rating: 50,
      parent_id: game_2.id
    )
    assert game_5.valid?
    assert_not_nil game_5.name
    assert_includes Game.categories.keys, game_5.category
    assert_equal "main_game", game_5.parent.category

    game_6 = games(:game_6)
    assert game_6.valid?
    assert_not_nil game_6.name
    assert_includes Game.categories.keys, game_6.category
    assert_nil game_6.parent
  end

  test "Validate presence of name" do
    # skip
    game_without_name = Game.create

    assert_not game_without_name.valid?
    assert_includes game_without_name.errors.full_messages, "Name can't be blank"
  end

  test "Validate uniqueness of name" do
    # skip
    game_duplicate_name = games(:game_1).dup

    assert_not game_duplicate_name.valid?
    assert_includes game_duplicate_name.errors.full_messages, "Name has already been taken"
  end

  test "Validate rating is between 0 and 100" do
    # skip
    game = games(:game_invalid_with_invalid_rating)
    assert_not game.valid?
    assert_includes game.errors.full_messages, "Rating must be less than or equal to 100"
  end

  test "Validate expansion has parent game" do
    # skip
    game_invalid_expansion_without_parent = Game.create(
      name: "Invalid Expansion Without Parent",
      category: 1,
      rating: 50
    )

    assert_not game_invalid_expansion_without_parent.valid?
    assert_includes game_invalid_expansion_without_parent.errors.full_messages,
                    "Parent should be a valid parent game"
  end
  test "Validate main game does not have parent_id" do
    skip
    game_invalid_main_game_with_parent_id = Game.create(
      name: "Invalid Main Game With Parent ID",
      category: 0,
      rating: 50,
      parent: game_1
    )

    assert_not game_invalid_main_game_with_parent_id.valid?
    assert_includes game_invalid_main_game_with_parent_id.errors.full_messages,
                    "Parent should be a valid parent game"
  end
end
