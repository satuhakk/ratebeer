require 'rails_helper'

include Helpers

describe 'User page' do
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3" }
  let!(:beer2) { FactoryGirl.create :beer, name:"Green Gold" }
  let!(:user1) { FactoryGirl.create :user, username:"Tiia" }
  let!(:rating) { FactoryGirl.create :rating, beer:beer1, user:user1}

  it "lists users ratings" do
    user2 = FactoryGirl.create :user
    FactoryGirl.create :rating, beer:beer2, user:user2
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user2)
    expect(page).to have_content "#{beer2.name}"
    expect(page).to have_no_content "#{beer1.name}"
    save_and_open_page
  end

end
