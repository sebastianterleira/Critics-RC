# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"

companies_data = JSON.parse(File.read("db/data/companies.json"))
games_data = JSON.parse(File.read("db/data/games.json"))
genres_data = JSON.parse(File.read("db/data/genres.json"))
platforms_data = JSON.parse(File.read("db/data/platforms.json"))

puts "Start seeding"
Company.destroy_all
Platform.destroy_all
Genre.destroy_all
Game.destroy_all

puts "Seeding Games"
# User.create(username: "user_test", email: "user@mail.com", role: 1)

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
genres_data.each do |name|
  new_genre = Genre.new(name: name)
  puts "Genre not created. Errors: #{new_genre.errors.full_messages}" unless new_genre.save
end

puts "Seeding main games and relationships"

main_games_data = games_data.select {|game| game["parent"].nil? }

main_games_data.each do |game|
  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  game["genres"].each do |genre_name|
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end

puts "Seeding expansion games and relationships"
expansions_games_data = games_data.select {|game| !game["parent"].nil? }

expansions_games_data.each do |game|
  parent_game = Game.find_by(name: game["parent"])

  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  new_game.parent = parent_game
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  game["genres"].each do |genre_name|
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    company = Company.find_by(name: involved_company_data["name"])
    
    new_involved_company = InvolvedCompany.new( game: new_game,
      company: company,
      publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end

  Company.all.each.with_index do |company,i|
    company.cover.attach(io: File.open("db/images/comp#{i+1}.png"), filename: "comp#{i+1}.png")
  end
end

Game.all.each_with_index do |games,i|
  games.cover.attach(io: File.open("db/images/img#{i+1}.png"), filename: "img#{i+1}.png")
  unless games.cover.attached?
    puts "No sale"
  end
end
