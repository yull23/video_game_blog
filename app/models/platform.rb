class Platform < ApplicationRecord
  # N to N relationship between Game and Platform
  has_and_belongs_to_many :games
end
