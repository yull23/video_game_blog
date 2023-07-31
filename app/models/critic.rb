class Critic < ApplicationRecord
  # Relation N to 1 with User
  # Adding parameter for Critic count
  belongs_to :user, counter_cache: true
  # Adding polymorphic relationship
  belongs_to :criticable, polymorphic: true

  # Model validation
  # validates :body, presence: true, length: { maximum: 40 }

  # Conteo
  # after_create :count_create_critic
  # after_destroy :count_destroy_critic

  # private

  # def count_create_critic
  #   user_count = user
  #   user.critics_count += 1
  #   user_count.save
  # end

  # def count_destroy_critic
  #   user_count = user
  #   user.critics_count -= 1
  #   user_count.save
  # end
end
