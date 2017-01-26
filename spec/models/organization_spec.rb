require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "Organization" do
    it "has to be real" do
      expect{Organization.new}.to_not raise_error
    end
    it "has a name" do
      new_org = Organization.new
      new_org.name = "ABC"
      expect(new_org.name).to eq "ABC"
    end
    it "has a description" do
      new_org = Organization.new
      new_org.description = "ABC is a helpful org"
      expect(new_org.description).to eq "ABC is a helpful org"
    end
    it "has an image" do
      new_org = Organization.new
      new_org.image_file_name = "spec/fixtures/default_org.png"
      expect(new_org.image_file_name).to eq "spec/fixtures/default_org.png"
    end
    it "should save" do
      new_org = Organization.new(name: "ABC", description: "ABC is a helpful org", image_file_name: "spec/fixtures/default_org.png")
      expect{new_org.save}.to_not raise_error
    end
  end
end
