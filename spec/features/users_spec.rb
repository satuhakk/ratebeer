require 'rails_helper'

include Helpers

describe "User" do

  describe "who has signed up" do

    let!(:user) { FactoryGirl.create :user }

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")
      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "can delete own ratings" do
      sign_in(username:"Pekka", password:"Foobar1")
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create :rating, beer:beer, user:user
      expect(user.ratings.count).to eq(1)
      visit user_path(user)
      click_link('delete')
      expect(user.ratings.count).to eq(0)
    end

  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end
