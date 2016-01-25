class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
    @beers = Beer.all
    # tässä renderöidään oletuksena näkymätemplate /app/views/ratings/index.html
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end

end
