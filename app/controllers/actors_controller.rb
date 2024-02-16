class ActorsController < ApplicationController
  def index
    respond_to do |format|
      # Respond to ajax request that contains search param
      format.json do
        actors = Actor.all.where('LOWER(name) iLike ?', "%#{params[:search_param]&.downcase}%")
        render json: { actors: actors.map { |a| [a.name, a.id] }  }
      end
    end
  end

  def show
    @actor = Actor.find_by_id(params[:id])
  end
end