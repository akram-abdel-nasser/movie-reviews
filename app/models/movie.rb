class Movie < ApplicationRecord
  # RELATIONS #
  has_many :movie_locations, dependent: :destroy
  has_many :locations, through: :movie_locations
  has_many :movie_actors, dependent: :destroy
  has_many :actors, through: :movie_actors
  has_many :reviews, dependent: :destroy
  belongs_to :director

  # VALIDATIONS #
  validates_uniqueness_of :name

  def self.sorted_by_average_stars
    joins(:reviews)
      .group('movies.id')
      .order('AVG(reviews.stars) DESC NULLS LAST')
  end
end
