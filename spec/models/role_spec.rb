require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "Role" do
    it "has to be real" do
      expect{Role.new}.to_not raise_error
    end
    it "has a name" do
      new_role = Role.new
      new_role.name = "Volunteer"
      expect(new_role.name).to eq "Volunteer"
    end
    it "should save" do
      new_role = Role.new
      new_role.name = "Volunteer"
      expect{new_role.save}.to_not raise_error
    end
  end
end
