class Critic < ApplicationRecord
  # Relation N to 1 with User
  belongs_to :user
  # Adding polymorphic relationship
  belongs_to :criticable, polymorphic: true
end
