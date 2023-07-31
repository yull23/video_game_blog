class Platform < ApplicationRecord
  # N to N relationship between Game and Platform
  has_and_belongs_to_many :games
  # Adding list of platforms
  enum :category, {
    console: 0,
    arcade: 1,
    platform: 2,
    operating_system: 3,
    portable_console: 4,
    computer: 5
  }

  # Model Validation
  # validates :name, uniqueness: true, presence: true
  # validates :category, presence: true
end
