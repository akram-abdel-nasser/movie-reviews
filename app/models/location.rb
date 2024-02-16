class Location < ApplicationRecord
  # RELATIONS #
  has_many :movie_locations, dependent: :destroy
  has_many :movies, through: :movie_locations
  has_many :actors, through: :movie_locations
end
