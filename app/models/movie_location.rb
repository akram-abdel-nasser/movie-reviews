class MovieLocation < ApplicationRecord
  belongs_to :location
  belongs_to :movie
end
