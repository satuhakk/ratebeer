require 'rails_helper'

include Helpers

describe "Ratings page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style) { FactoryGirl.create :style, name:"Ale"}
  let!(:beer1) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating) { FactoryGirl.create :rating, beer:beer1, user:user}

  it "should list existing ratings and their total number" do
    visit ratings_path
    expect(page).to have_content "Number of ratings: #{Rating.all.count}"
    Rating.all.each do |r|
      expect(page).to have_content r.beer.name
    end
  end

end
