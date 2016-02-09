require 'rails_helper'

include Helpers

describe 'User page' do
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3" }
  let!(:beer2) { FactoryGirl.create :beer, name:"Green Gold" }
  let!(:user1) { FactoryGirl.create :user, username:"Tiia" }
  let!(:user2) { FactoryGirl.create :user }
  let!(:rating1) { FactoryGirl.create :rating, beer:beer1, user:user1 }
  let!(:rating2) { FactoryGirl.create :rating, beer:beer2, user:user2 }

  it "lists users ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user2)
    expect(page).to have_content "#{beer2.name}"
    expect(page).to have_no_content "#{beer1.name}"
  end

  it "shows users favorite beer style" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user2)
    expect(page).to have_content "#{user2.favorite_style}"
  end

  it "shows users favorite brewery" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user2)
    expect(page).to have_content "#{user2.favorite_brewery}"
  end

end
