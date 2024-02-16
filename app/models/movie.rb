class Movie < ApplicationRecord
  # RELATIONS #
  has_many :movie_locations, dependent: :destroy
  has_many :locations, through: :movie_locations
  has_many :movie_actors, dependent: :destroy
  has_many :actors, through: :movie_actors
  belongs_to :director
  accepts_nested_attributes_for :actors
end
