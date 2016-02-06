class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, length: { minimum: 1 }
  validates :year, numericality: {  greater_than_or_equal_to: 1042,
                                    only_integer: true }
  validate :year_is_current_or_less

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts self
    puts "Established in #{self.year}"
    puts "Number of beers: #{self.beers.count}"
  end

  def restart
    self.year = 2016
    puts "changed year to #{year}"
  end

  def year_is_current_or_less
    if self.year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
  end
end
