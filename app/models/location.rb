class Location < ApplicationRecord
  # RELATIONS #
  has_many :movie_locations, dependent: :destroy
  has_many :movies, through: :movie_locations
  has_many :actors, through: :movie_locations

  # VALICATIONS #
  validates :name, uniqueness: { scope: %i[country] }
end
