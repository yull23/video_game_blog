require "json"

companies_data = JSON.parse(File.read("db/data/companies.json"))
games_data = JSON.parse(File.read("db/data/games.json"))
genres_data = JSON.parse(File.read("db/data/genres.json"))
platforms_data = JSON.parse(File.read("db/data/platforms.json"))

# p companies_data.present? && games_data.present? && genres_data.present? && platforms_data.present?

puts "Start seeding"

Company.destroy_all
Platform.destroy_all
Genre.destroy_all
Game.destroy_all


puts "Seeding companies"
companies_data.each do |company_data|
  new_company = Company.new(company_data)
  puts "Company not created. Errors: #{new_company.errors.full_messages}" unless new_company.save
end
puts "Seeding platforms"
platforms_data.each do |platform_data|
  new_platform = Platform.new(platform_data)
  puts "Platform not created. Errors: #{new_platform.errors.full_messages}" unless new_platform.save
end
puts "Seeding genres"
genres_data.each do |genre_data|
  new_genre = Genre.new(name:genre_data)
  puts "Genre not created. Errors: #{new_genre.errors.full_messages}" unless new_genre.save
end

puts "Seeding main games"

main_games_data=games_data.select {|main_game_data| main_game_data["parent"].nil?}


main_games_data.each do |main_game_data|
  game_main=main_game_data.slice("name", "summary", "release_date", "category", "rating")
  new_game=Game.new(game_main)
  puts "Game not created. Errors: #{new_game.errors.full_messages} #{new_game.id}" unless new_game.save

  # Attributes with associations
  genres=main_game_data["genres"]
  platforms=main_game_data["platforms"]
  involed_companies=main_game_data["involved_companies"]

  # Seeding genres to main game

  genres.each do |genre|
    new_game.genres << Genre.find_by(name:genre)
  end

  # Seeding platforms to main game
  platforms.each do |platform|
    new_game.platforms << Platform.find_by(name:platform["name"])
  end

  # Seeding involed_companies to main game

  involed_companies.each do |involed_company_data|
    company=Company.find_by(name:involed_company_data["name"])
    new_involed_company = InvoledCompany.new(
      game:new_game,
      company:company,
      developer:involed_company_data["developer"],
      publisher:involed_company_data["publisher"]
    )
    puts "Involved Company not created. Errors: #{new_involed_company.errors.full_messages}" unless new_involed_company.save
  end
end


puts "Seeding games expansions"

expansions_games_data=games_data.select {|expansions_game_data| !expansions_game_data["parent"].nil?}

expansions_games_data.each do |expansions_game_data|
  # Datos iniciales
  expansion_game=expansions_game_data.slice("name", "summary", "release_date", "category", "rating","parent")
  # Game parent
  parent_game=Game.find_by(name:expansions_game_data["parent"])
  expansion_game["parent"]=parent_game
  # # Ahora expansion tiene referenciado parent
  new_game=Game.new(expansion_game)
  puts "Game not created. Errors: #{new_game.errors.full_messages} #{new_game.id}" unless new_game.save
  
  # Attributes with associations
  genres=expansions_game_data["genres"]
  platforms=expansions_game_data["platforms"]
  involed_companies=expansions_game_data["involved_companies"]

  # Seeding genres to main game

  genres.each do |genre|
    new_game.genres << Genre.find_by(name:genre)
  end

  # Seeding platforms to main game
  platforms.each do |platform|
    new_game.platforms << Platform.find_by(name:platform["name"])
  end

  # Seeding involed_companies to main game

  involed_companies.each do |involed_company_data|
    company=Company.find_by(name:involed_company_data["name"])
    new_involed_company = InvoledCompany.new(
      game:new_game,
      company:company,
      developer:involed_company_data["developer"],
      publisher:involed_company_data["publisher"]
    )
    puts "Involved Company not created. Errors: #{new_involed_company.errors.full_messages}" unless new_involed_company.save
  end
end







