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
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end
