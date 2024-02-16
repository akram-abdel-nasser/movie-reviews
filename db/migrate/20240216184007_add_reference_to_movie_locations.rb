class AddReferenceToMovieLocations < ActiveRecord::Migration[6.0]
  def change
    add_reference :movie_locations, :actor, index: true
  end
end
