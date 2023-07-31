class Genre < ApplicationRecord
  # N to N relationship between Game and Genre
  has_and_belongs_to_many :games

  # Model Validation
  validates :name, uniqueness: true, presence: true
end
