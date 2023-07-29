class Company < ApplicationRecord
  # N to N relationship between Game and Company through InvoledCompany
  has_many :involed_companies, dependent: :destroy
  has_many :game, through: :involed_companies
  # Relating polymorphically to the Critic model through criticable
  has_many :critics, as: :criticable, dependent: :destroy
end
