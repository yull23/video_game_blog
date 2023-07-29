# README

Primero se realiza la creación de los modelos

## Creación de modelos

1. Modelo User
   Posee una relación de 1 a N con el modelo Critic
   Se realiza primeramente
   rails generate model User

## Associations between models

### Relationships from 1 to N and N to N.

1. Relationship

   - (√) A Critic belongs to a user
   - (√) A User has many critics
   - (√) A Company has many involved_companies and has many games through involved_companies
   - (√) An InvolvedCompany belongs to a company and belongs to a game
   - (√) A Game has many involved_companies and has many companies through involved_companies
   - (√) A Game has and belongs to many platforms
   - (√) A Game has and belongs to many genres
   - (√) A Platform has and belongs to many games
   - (√) A Genre has and belongs to many games

2. Relationship between User - Critic

   The relationship from 1 to N is made, between User and Critic, it is also considered that when a user is eliminated, the criticisms that he has made are eliminated, therefore, the dependent:destroy is necessary.

   ```
   class User < ApplicationRecord
     has_many :critics, dependent: :destroy
   end

   class Critic < ApplicationRecord
     belongs_to :user
   end
   ```

3. Relationship between Game - InvoledCompany - Company

   The relationship between Game and Company is from N to N, through the InvoledCompany model.  
   You must put dependent:destroy, since when you delete a game or company, it should delete the object that contains those deleted models

   ```
   class Game < ApplicationRecord
     has_many :involed_companies, dependent: :destroy
     has_many :companies, through: :involed_companies
   end

   class InvoledCompany < ApplicationRecord
     belongs_to :company
     belongs_to :game
   end

   class Company < ApplicationRecord
     has_many :involed_companies, dependent: :destroy
     has_many :game, through: :involed_companies
   end

   ```

4. Relationship between Game - (Genre / Platform)

   The relationship between Game and Company is from N to N through an automatic intermediate table, this must have been created through the CreateJoinTable migration:

   ```
   rails g migration CreateJoinTableGamePlatform game platform
   rails g migration CreateJoinTableGameGenre game genre
   ```

   The corresponding relationships between the models are made (The dependent: destroy will not be necessary, since removing any game does not affect the existence of the genres or platforms, and vice versa).

   ```
   class Game < ApplicationRecord
     # N to N relationship between Game and Genre
     has_and_belongs_to_many :genres
     # N to N relationship between Game and Platform
     has_and_belongs_to_many :platforms
   end

   class Genre < ApplicationRecord
     # N to N relationship between Game and Genre
     has_and_belongs_to_many :games
   end

   class Platform < ApplicationRecord
     # N to N relationship between Game and Platform
     has_and_belongs_to_many :games
   end
   ```

### Self bound relationships
