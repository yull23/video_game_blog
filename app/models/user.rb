class User < ApplicationRecord
  has_many :critics, dependent: :destroy

  # Model Validation
  validates :username, presence: true,
                       format: { with: /\A[A-Za-z0-9]+\z/, message: "must only contain letters and numbers" },
                       uniqueness: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" },
                    uniqueness: true
  validate :birth_date_min_age

  private

  def birth_date_min_age
    return unless birth_date.present? && birth_date > 16.years.ago

    errors.add(:birth_date, "You should be 16 years old to create an account")
  end
end
