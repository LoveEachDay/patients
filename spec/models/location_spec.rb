require 'rails_helper'

RSpec.describe Location, type: :model do
  it "is invalid without a name" do
    location = build(:location, name: nil)
    location.valid?
    expect(location.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a name has more than 80 characters" do
    location = build(:location, name: 'a'*81)
    location.valid?
    expect(location.errors[:name]).to include("80 characters is the maximum allowed")
  end

  it "is invalid with a code has more than 10 characters" do
    location = build(:location, code: 'a'*11)
    location.valid?
    expect(location.errors[:code]).to include("10 characters is the maximum allowed")
  end

  it "is valid with a name" do
    expect(build(:location)).to be_valid
  end
end
