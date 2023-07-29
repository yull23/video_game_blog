class Game < ApplicationRecord
  # N to N relationship between Game and Company through InvoledCompany
  has_many :involed_companies, dependent: :destroy
  has_many :companies, through: :involed_companies
  # N to N relationship between Game and Genre
  has_and_belongs_to_many :genres
  # N to N relationship between Game and Platform
  has_and_belongs_to_many :platforms
end
