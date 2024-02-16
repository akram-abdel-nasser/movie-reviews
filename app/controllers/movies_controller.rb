class MoviesController < ApplicationController
  def index
    @movies = Movie.sorted_by_average_stars
  end

  def show
    @movie = Movie.find_by_id(params[:id])
  end
end
