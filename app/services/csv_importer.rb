require 'csv'

class CsvImporter
  def initialize(file_path:, file_type:)
    @file_path = file_path
    @file_type = file_type
  end

  def import
    case @file_type
    when 'movies'
      import_movies
    when 'reviews'
      import_reviews
    else
      raise ArgumentError, "Invalid file type: #{@file_type}"
    end
  end

  def import_movies
    @movies = prepare_pre_existing_objects(Movie)
    @actors = prepare_pre_existing_objects(Actor)
    @directors = prepare_pre_existing_objects(Director)
    @locations = {}

    CSV.foreach(@file_path, headers: true) do |row|
      prepare_movie(row.to_h)
    end

    @movies.values.each(&:save)
  end

  def import_reviews
    @reviews = []

    CSV.foreach(@file_path, headers: true) do |row|
      prepare_review(row.to_h)
    end

    Review.import(@reviews)
  end

  def prepare_movie(row)
    movie = @movies[row['Movie']] || Movie.find_or_initialize_by(name: row['Movie'])
    movie.description = row['Description']
    movie.year = row['Year']
    
    actor = @actors[row['Actor']] || Actor.find_or_initialize_by(name: row['Actor'])
    director = @directors[row['Director']] || Director.find_or_initialize_by(name: row['Director'])

    movie.movie_actors.build(actor: actor)
    movie.director = director

    location_name = "#{row['Filming location']}#{row['Country']}"
    location = @locations[location_name] || Location.find_or_create_by(name: row['Filming location'], country: row['Country'])
    
    movie.movie_locations.build(actor: actor, location: location)

    @movies[row['Movie']] = movie
    @actors[row['Actor']] = actor
    @directors[row['Directors']] = director
    @locations[location_name] = location
  end

  def prepare_review(row)
    movie = Movie.find_by_name(row['Movie'])
    return unless movie.present?

    # Assuming a user can add the same review more than once, and also assuming there is no sign up being done for users
    review = Review.new(username: row['User'], stars: row['Stars'], title: row['Review'], movie_id: movie.id)
    @reviews << review
  end

  def prepare_pre_existing_objects(model)
    hash = {}
    model.pluck(:name, :id).each_slice(1000) do |batch|
      object = model.where(id: batch.map(&:second)).index_by(&:id)
      hash.merge!(batch.to_h { |name, id| [name, object[id]] })
    end
    hash
  end
end
