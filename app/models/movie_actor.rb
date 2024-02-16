class MovieActor < ApplicationRecord
  # RELATIONS #
  belongs_to :actor
  belongs_to :movie

end
