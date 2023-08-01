require "test_helper"

class CriticTest < ActiveSupport::TestCase
  def setup
    @user = users :valid_user_1
    @game = games :game_1
    @company = companies :company_1
    # p @game.present?
    # p @company.present?
    # p @user.present?
    @critic_valid_1 = Critic.create(
      title: "title",
      body: "body",
      user: @user,
      criticable: @game
    )
    @critic_valid_2 = Critic.create(
      title: "title",
      body: "body",
      user: @user,
      criticable: @company
    )

    # p @critic_valid_1.present?
    # p @critic_valid_2.present?
  end

  test "Validate correct critics" do
    critic_1 = critics :valid_critic_for_game_1
    assert critic_1.title.present?
    assert critic_1.body.present?
    assert critic_1.present?
    critic_2 = critics :valid_critic_for_company_1
    assert critic_2.title.present?
    assert critic_2.body.present?
    assert critic_2.present?
  end

  test "Validation for critics without user, title or body" do
    critic_without_user_title_or_body = Critic.new
    # p critic_without_user_title_or_body.valid?
    # p critic_without_user_title_or_body.errors.full_messages
    assert_not critic_without_user_title_or_body.valid?
    assert_includes critic_without_user_title_or_body.errors.full_messages, "User must exist"
    assert_includes critic_without_user_title_or_body.errors.full_messages, "Criticable must exist"
    assert_includes critic_without_user_title_or_body.errors.full_messages, "Body can't be blank"
  end

  test "Validation of the belong_to user relationship." do
    critic_belong_to_user_1 = critics :valid_critic_for_game_1
    assert_equal critic_belong_to_user_1.user.id, @user.id
  end

  test "Validation of the polymorphic relationship" do
    # skip
    assert_equal @critic_valid_1.criticable, @game
    assert_equal @critic_valid_2.criticable, @company
  end
end
