class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
    # tässä renderöidään oletuksena näkymätemplate /app/views/ratings/index.html
  end

end
