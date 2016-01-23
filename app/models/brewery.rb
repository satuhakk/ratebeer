class Brewery < ActiveRecord::Base
  has_many :beers

  def print_report
    puts self
    puts "Established in #{self.year}"
    puts "Number of beers: #{self.beers.count}"
  end

  def restart
    self.year = 2016
    puts "changed year to #{year}"
  end
end
