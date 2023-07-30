# README

Primero se realiza la creación de los modelos

## Creación de modelos

1. Modelo User
   Posee una relación de 1 a N con el modelo Critic
   Se realiza primeramente
   rails generate model User

## Associations between models

We have the associations of the following relationships between models:

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

### Relationships Self Joins

There is only one model that has this relationship, and that is the Game model, which is expected to be related to it, through the parent, which means that a parent can have many games (children or expansions), while one game can only have one father

When having a Self Join relationship, you must have a column that stores that relationship. Therefore, the migration and editing of the file is carried out first.

Adding reference to the game model.

```
# rails generate migration AddParentToGame parent:references
class AddParentToGame < ActiveRecord::Migration[7.0]
  def change
    add_reference :games, :parent, foreign_key: {to_table: :games}
  end
end
```

Associating to the same table (Model).

```
class Game < ApplicationRecord
  has_many :expansions, class_name: "Game",
                        foreign_key: "parent_id",
                        dependent: :destroy,
                        inverse_of: "parent"
  belongs_to :parent, class_name: "Game", optional: true
end
```

These methods allow one Game to be associated to another, through the parent_id ("parent") column, and to access the expansions inversely, through the expansions attribute, as if it were a new column.

```
game=Game.create(name:"Mario Bros")
game_parent=Game.create(name:"Mario Bros Run")
game_parent.update(parent:game)

game_expansion=Game.create(name:"Residen Evil")
game_expansion.expansions.create(name: "Resident Evil 2")
```

### Polymorphic relationships

First, the migration is carried out to create the columns corresponding to a polymorphic association.

Adding reference to the game model.

```
# rails generate migration AddCriticableToCritics criticable:references{polymorphic}
class AddCriticableToCritics < ActiveRecord::Migration[7.0]
  def change
    add_reference :critics, :criticable, polymorphic: true, null: false
  end
end
```

It is declared that it can be used to other models by means of the polymorphic association (link = > criticable)

```
class Critic < ApplicationRecord
  # Relation N to 1 with User
  belongs_to :user
  # Adding polymorphic relationship
  belongs_to :criticable, polymorphic: true
end
```

The creation of the suffix columns "type" and "id" should be checked

```
  create_table "critics", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "criticable_type", null: false
    t.bigint "criticable_id", null: false
    t.index ["criticable_type", "criticable_id"], name: "index_critics_on_criticable"
    t.index ["user_id"], name: "index_critics_on_user_id"
  end
```

Thus, to create a critical object, it must be linked to a company or game, by using criticable:, criticable_type: or criticable_id:

```
user=User.create(username:"Yull")
company=Company.create(name:"Nintendo")
game=Game.create(name:"Mario Bros")
user.critics.create(title:"Title",criticable:game)
user.critics.create(title:"Title",criticable:company)

Critic.create(
  title:"Title",
  user_id:1,
  criticable_type:"Game",
  criticable_id:1
)
Critic.create(
  title:"Title",
  user_id:1,
  criticable_type:"Company",
  criticable_id:1
)
```

## Query interface

For the interface query, the enum method is used to encapsulate the key:value, corresponding to a column.
Estos valores al momento de crear las tablas, si no se especifica, posee un valor por defecto de null, para ello se debe realizar la migración reversible correspondiente, para que puedan optar el valor por defecto que se requiera.

### Enum in games category

On first test, you don't bind these values to the parent_id column, just make the declaration

```
class Game < ApplicationRecord
  enum :category, {
    main_game: 0,
    expansion: 1
  }
end
```

Adding the default value, depending on the migration:

```
# rails generate migration AddDefaultCategoryToGames
class AddDefaultCategoryToGames < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up {change_column :games, :category, :integer, default:0}
      dir.down {change_column :games, :category, :integer, default:nil}
    end
  end
end
```

### Enum in platform name

In the same way, the key:value assignment is made for the category column.

```
class Platform < ApplicationRecord
  enum :category, {
    console: 0,
    arcade: 1,
    platform: 2,
    operating_system: 3,
    portable_console: 4,
    computer: 5
  }
end
```

For this case, a default value must be assigned in the same way, however, according to the rails guide, there is the change_column_default method.

```
# rails generate migration AddDefaultCategoryToPlatforms
class AddDefaultCategoryToPlatforms < ActiveRecord::Migration[7.0]
  def change
    change_column_default :platforms, :category, from:nil, to: 0
  end
end
```

## Callback

Los Callbacks utilizados
