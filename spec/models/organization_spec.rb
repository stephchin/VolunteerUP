require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "Organization" do
    it "has to be real" do
      expect{Organization.new}.to_not raise_error
    end
    it "should save" do
      new_org = Organization.new(name: "ABC", description: "ABC is a helpful org")
      new_org.save
      expect(new_org.name).to eq "ABC"
      expect(new_org.description).to eq "ABC is a helpful org"
    end
  end
end
