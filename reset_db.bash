# Reset db development
rails db:drop
rails db:create
rails db:migrate
rails db:seed
# Resete db test
# rails db:drop RAILS_ENV=test
# rails db:create RAILS_ENV=test
# rails db:migrate RAILS_ENV=test