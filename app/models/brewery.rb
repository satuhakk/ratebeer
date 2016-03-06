class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, length: { minimum: 1 }
  validates :year, numericality: {  greater_than_or_equal_to: 1042,
                                    only_integer: true }
  validate :year_is_current_or_less

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

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

  def self.top(n)
     Brewery.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
  end

  # def self.sarakesort(var, session_var)
  #   att = var.gsub!(/\A"|"\Z/, '')
  #   case session_var when var then self.sort_by{ |i| i.att }
  #   end
  # end

end
