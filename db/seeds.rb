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
user.critics.create(title:"Title")
company=Company.create(name:"Nintendo")
game=Game.create(name:"Mario Bros")
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


game_parent=Game.create(name:"Mario Bros Run")
game_parent.update(parent:game)

game_expansion=Game.create(name:"Residen Evil")
game_expansion.expansions.create(name: "Resident Evil 2")

