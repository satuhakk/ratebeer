class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    #Etsitään olutta koskevat arvostelut:
    @ratings = Rating.all
    #Keskiarvo:
    #Vanha: @ratings.where(beer_id:self.id).inject(0){|sum, item| sum + item.score}.to_f / @ratings.where(beer_id:self.id).length
    @ratings.where(beer_id:self.id).average(:score).to_f
  end

  def to_s
    "#{self.name} by #{Brewery.find_by(id:self.brewery_id).name}"
  end

end
