require 'rails_helper'

describe "Beers page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  it "should add a beer when the name is valid" do
    visit new_beer_path
    fill_in('beer_name', with:'Hardcore IPA')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "should show an error message if the name is not valid" do
    visit new_beer_path
    click_button('Create Beer')
    expect(page).to have_content 'Name is too short (minimum is 1 character)'
  end

end
