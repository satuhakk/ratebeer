class RatingsController < ApplicationController
  before_action :skip_if_cached, only: [:index]

  def skip_if_cached
    return render :index if fragment_exist?( "ratings-stats"  )
  end

  def index
    @ratings = Rating.all
    @beers = Beer.all
    @beers_top3 = Beer.top(3)
    @breweries_top3 = Brewery.top(3)
    @styles_top3 = Style.top(3)
    @ratings_recent = Rating.recent
    @users_top3 = User.most_ratings(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end

  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

end
