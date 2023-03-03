# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "net/http"


Movie.destroy_all

p "clearing database..."

popular_movies_api = "https://api.themoviedb.org/3/movie/popular?api_key=0f1b3e53a55883fcff92a04cccc3571e&language=en-US&page=1"

class GetRequester
  def initialize(url)
    @url = url
  end

  def get_response_body
    url = URI.parse(@url)
    resp = Net::HTTP.get_response(url)
    JSON.parse(resp.body)
  end
end

popular_movies_response = GetRequester.new(popular_movies_api)
popularMovies = popular_movies_response.get_response_body

popularMovies["results"].each do |movie|
  movieTitle = movie["title"]
  movieOverview = movie["overview"]
  moviePoster_url = movie["poster_path"]
  movieRating = movie["vote_average"]
  Movie.create(title: movieTitle, overview: movieOverview, poster_url: moviePoster_url, rating: movieRating)
  p "Created movie: ##{Movie.count}"
end

p "Created #{Movie.count} movies"
