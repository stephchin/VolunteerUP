require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User can be made" do
    it "exists" do
      expect{User.new}.to_not raise_error
    end
    it "should save to db" do
      u = User.new(name: "Suzan", email: "123@yahoo.com", password: "123456", city: "San Diego", state: "CA")
      expect(u.save).to eq true
      expect(u.name).to eq "Suzan"
      expect(u.email).to eq "123@yahoo.com"
      expect(u.city).to eq "San Diego"
      expect(u.state).to eq "CA"
    end
  end
end
