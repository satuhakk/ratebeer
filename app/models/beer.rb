class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    #Etsitään olutta koskevat arvostelut:
    @ratings = Rating.all
    #kaikki = @ratings.where beer_id:self.id

    #Summataan arvot:
    #kaikki = @ratings.where(beer_id:self.id).inject(0){|sum, item| sum + item.score}

    #Keskiarvo:
    keskiarvo = @ratings.where(beer_id:self.id).inject(0){|sum, item| sum + item.score}.to_f / @ratings.where(beer_id:self.id).length

  end

end
