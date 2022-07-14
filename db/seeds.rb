# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "json"
require "open-uri"

url = "https://tmdb.lewagon.com/movie/top_rated"
user_serialized = URI.open(url).read
movies = JSON.parse(user_serialized)["results"].first(20)


puts "cleaning up database"
Bookmark.destroy_all
Movie.destroy_all
puts "database is clean"

puts "creating movies..."

movies.each do |movie|
  movie = Movie.create(title: movie["title"],
    overview: movie["overview"],
    poster_url: movie["poster_path"],
    rating: movie["vote_average"]
  )
  puts "movie #{movie.id} is created"
end

puts "creating lists..."

10.times do
  list = List.create(
    name: Faker::Color.color_name,
  )
  puts "list #{list.id} is created"
end

puts "done"

# 10.times do
# movie = Movie.create(
#   title: Faker::Movie.title,
#   overview: Faker::Movie.quote,
#   poster_url: "",
#   rating: rand(1..5)
# )
# puts "movie #{movie.id} is created"
# end
