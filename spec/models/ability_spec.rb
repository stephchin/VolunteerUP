require 'rails_helper'

RSpec.describe Ability, type: :model do

  before(:each) do
    @u1 = User.find_by_email("a@yahoo.com")
    @u1.add_role :admin
    @u3 = User.find_by_email("c@yahoo.com")
    @u3.add_role :volunteer
    @u2 = User.find_by_email("b@yahoo.com")
    @u2.add_role :volunteer
    @o1 = Organization.find_by_name("We Help")
    @o2 = Organization.find_by_name("Red Cross")
    @o1.users << @u1
    @o1.users << @u2
    @u3.organizations << @o1
    @ability = Ability.new(@u1)
    @ability3 = Ability.new(@u3)
    @ability2 = Ability.new(@u2)
  end

  describe "Ability" do
    it "has to be real and assigned to a user" do
      expect{Ability.new(@u1)}.to_not raise_error
    end
    it "gives admins the ability to manage all" do
      expect(@ability.can? :manage, :all).to eq true
      expect(@ability.can? :read, :all).to eq true
    end
    it "gives organizers the ability to read all, new/create org, and new/create event" do
      expect(@ability3.can? :manage, :all).to eq false
      expect(@ability3.can? :read, :all).to eq true
      expect(@ability3.can? :new, Organization).to eq true
      expect(@ability3.can? :create, Organization).to eq true
      expect(@ability3.can? :new, Event).to eq true
      expect(@ability3.can? :create, Event).to eq true
    end
    it "provides the correct volunteer abilities" do
      expect(@ability2.can? :manage, :all).to eq false
      expect(@ability2.can? :new, Organization).to eq true
      expect(@ability2.can? :create, Organization).to eq true
      expect(@ability2.can? :add_user, Organization).to eq true
      expect(@ability2.can? :read, :all).to eq true
    end
  end
end
