# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
 
# Datos de prueba
InvoledCompany.destroy_all
Company.destroy_all
Game.destroy_all
Critic.destroy_all
User.destroy_all


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

game.involed_companies.create(
  developer:true,
  publisher:true,
  company:company
)
genre_1=Genre.create(name:"Terror")
genre_2=Genre.create(name:"Adventure")
game.genres<<genre_1
game.genres<<genre_2
platform_1=Platform.create(name:"Platform_1")
platform_2=Platform.create(name:"Platform_2")
game.platforms<<platform_1
game.platforms<<platform_2


game_expansion=Game.create(name:"Mario Bros Run")
game_expansion.update(parent:game)

game_parent=Game.create(name:"Residen Evil")
game_parent.expansions.create(name: "Resident Evil 2")

