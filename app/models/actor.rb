class Actor < ApplicationRecord
  # RELATIONS #
  has_many :movie_actors, dependent: :destroy
  has_many :movies, through: :movie_actors
  has_many :movie_locations, dependent: :destroy
  has_many :locations, through: :movie_locations
end
