class MovieLocation < ApplicationRecord
  belongs_to :location
  belongs_to :movie
  belongs_to :actor
end
