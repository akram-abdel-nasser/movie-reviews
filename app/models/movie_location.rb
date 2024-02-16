class MovieLocation < ApplicationRecord
  # RELATIONS #
  belongs_to :location
  belongs_to :movie
  belongs_to :actor

  # VALIDATIONS #
  # validates :movie, uniqueness: { scope: %i[location actor] }
end
