class Actor < ApplicationRecord
  # RELATIONS #
  has_many :movie_actors
  has_many :movies, through: :movie_actors
end
