class InvoledCompany < ApplicationRecord
  # N to N relationship between Game and Company through InvoledCompany
  belongs_to :company
  belongs_to :game
end
