require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "has a number in the password" do
    user = User.create username:"Pekka", password:"Aaaa", password_confirmation:"Aaaa"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "has a password length of 4 characters or longer" do
    user = User.create username:"Pekka", password:"Aa1", password_confirmation:"Aa1"
    expect(user.valid?).to be (false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    # let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
       expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 30)
      best = create_beer_with_rating(user, 50)
      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
       expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating_and_style(user, 10, "Weizen")
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating if several rated" do
        create_beers_with_ratings_and_styles(user, [["IPA", 10], ["Weizen", 30], ["Weizen", 40]])
        best = create_beer_with_rating_and_style(user, 50, "Pale Ale")
        expect(user.favorite_style).to eq(best.style)
    end
  end

end

def create_beers_with_ratings_and_styles(user, arr)
  arr.each do |style, score|
    create_beer_with_rating_and_style(user, score, style)
  end
end

def create_beer_with_rating_and_style(user, score, style)
  beer = FactoryGirl.create(:beer, style:style)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating(user, score)
  end
end

def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end