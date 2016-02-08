require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved when name and style are set" do
    beer = Beer.create name:"Mufloni CCCCC", style:"IPA"

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "isn't saved without a name" do
    beer = Beer.create style:"IPA"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "isn't saved without a style" do
    beer = Beer.create name:"Koff"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
