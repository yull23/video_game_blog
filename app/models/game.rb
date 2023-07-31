class Game < ApplicationRecord
  # N to N relationship between Game and Company through InvoledCompany
  has_many :involed_companies, dependent: :destroy
  has_many :companies, through: :involed_companies
  # N to N relationship between Game and Genre
  has_and_belongs_to_many :genres
  # N to N relationship between Game and Platform
  has_and_belongs_to_many :platforms

  # Relation Self.Join, using parent and expansions
  has_many :expansions, class_name: "Game",
                        foreign_key: "parent_id",
                        dependent: :destroy,
                        inverse_of: "parent"
  belongs_to :parent, class_name: "Game", optional: true
  # Relating polymorphically to the Critic model through criticable
  has_many :critics, as: :criticable, dependent: :destroy
  # Adding enum to category table values
  enum :category, {
    main_game: 0,
    expansion: 1
  }
  # Model Validation
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :rating, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
    allow_nil: true
  }

  validate :validate_parent

  private

  def validate_parent
    if category == "expansion" && Game.find_by(id: parent_id).nil?
      errors.add(:parent_id, "should be a valid parent game")
    elsif category == "main_game" && parent_id
      errors.add(:parent_id, "should be nil")
    end
  end
end
