class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers


  def self.top(n)
    Style.all.sort_by(&:average_rating).reverse.first(n)
  end
end
