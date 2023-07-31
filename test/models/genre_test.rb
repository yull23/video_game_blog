require "test_helper"

class GenreTest < ActiveSupport::TestCase
  test "Validate correct genres" do
    # skip
    genre_1 = genres(:genre_1)
    assert genre_1.valid?
    assert_not_nil genre_1.name

    genre_2 = genres(:genre_2)
    assert genre_2.valid?
    assert_not_nil genre_2.name

    genre_3 = genres(:genre_3)
    assert genre_3.valid?
    assert_not_nil genre_3.name
  end

  test "Validate that name is required and unique" do
    skip
    # Género sin nombre debe ser inválido
    genre = Genre.new
    assert_not genre.valid?
    assert_includes genre.errors.full_messages, "Name can't be blank"

    # Género con nombre duplicado debe ser inválido
    genre_duplicate = Genre.new(name: "Action")
    assert_not genre_duplicate.valid?
    assert_includes genre_duplicate.errors.full_messages, "Name has already been taken"
  end
end
