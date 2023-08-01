class InvoledCompany < ApplicationRecord
  # N to N relationship between Game and Company through InvoledCompany
  belongs_to :company
  belongs_to :game
  # Model Validation

  validates :developer, inclusion: { in: [true, false] }
  validates :publisher, inclusion: { in: [true, false] }
  validates :company_id, uniqueness: {
    scope: :game_id,
    message: "should be a unique combination"
  }
end
