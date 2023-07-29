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
end
