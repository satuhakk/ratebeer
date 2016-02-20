require 'rails_helper'

describe "Beers page" do

  describe "when signed in" do

    let!(:user) { FactoryGirl.create :user }
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:style) { FactoryGirl.create :style}

    it "should add a beer when the name is valid" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit new_beer_path
      fill_in('beer_name', with:'Hardcore IPA')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "should show an error message if the name is not valid" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit new_beer_path
      click_button('Create Beer')
      expect(page).to have_content 'Name is too short (minimum is 1 character)'
    end

  end

end
