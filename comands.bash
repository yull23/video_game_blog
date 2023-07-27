# Reset db development
rails db:drop
rails db:create
rails db:migrate
# Resete db test
rails db:drop RAILS_ENV=test
rails db:create RAILS_ENV=test
rails db:migrate RAILS_ENV=test
# Models
rails g model User username email rol critics_count:integer
rails g model Critic title body:text user:references
rails g model Company name description:text start_date:date country cover
rails g model Game name summary:text release_date:date rating:decimal cover
rails g model InvoledCompany company:references game:references developer:boolean publisher:boolean
rails g model Platform name category:integer
rails g model Genre name
# Migrations
rails g migration CreateJoinTableGamePlatform game platform
rails g migration CreateJoinTableGameGenre game genre