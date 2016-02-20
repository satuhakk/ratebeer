class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, length: { minimum: 1 }
  validates_presence_of :style_id

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style

  def to_s
    "#{self.name} by #{Brewery.find_by(id:self.brewery_id).name}"
  end

end
