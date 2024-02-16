class Movie < ApplicationRecord
  # RELATIONS #
  has_many :movie_locations
  has_many :locations, through: :movie_locations
  has_many :movie_actors
  has_many :actors, through: :movie_actors
  belongs_to :director
end
