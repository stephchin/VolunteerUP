require 'rails_helper'
RSpec.describe UserOrganization, type: :model do

  before(:each) do
    @start = DateTime.new(2017,1,18,1,30)
    @end = DateTime.new(2017,1,18,5,30)
    @pw = "123456"
  end

  describe "User" do
    it "can be created and saved" do
      u1 = User.create(email: "a@yahoo.com", password: @pw, name: "Stephen")
      e1 = Event.create(name: "Blood", start_time: @start, end_time: @end,
        volunteers_needed: 10)
      e2 = Event.new(name: "Pestilence", start_time: @start, end_time: @end,
        volunteers_needed: 100)
      org = Organization.new(name: "The Red Cross", description: "A non-profit organization")
      expect(org.save).to eq true
      e1.organization = org
      e2.organization = org
      expect(u1.save).to eq true
      expect(e1.save).to eq true
      expect(e2.save).to eq true
    end

    it "can have many organizations" do
      u1 = User.create(email: "a@yahoo.com", password: @pw, name: "Stephen")
      org = Organization.new(name: "The Red Cross", description: "A non-profit organization")
      expect(org.save).to eq true
      org2 = Organization.new(name: "WWF", description: "A non-profit organization for animals")
      expect(org.save).to eq true
      expect(u1.user_organizations.new(organization: org).save).to eq true
      expect(u1.user_organizations.new(organization: org2).save).to eq true
      expect(u1.organizations.length).to eq 2
    end
  end

  describe "Organization" do

    it "can be created and saved" do
      o1 = Organization.create(name: "WWF", description: "animal lovers")
      u1 = User.create(email: "b@yahoo.com", password: @pw, name: "Stephen")
      u2 = User.create(email: "c@yahoo.com", password: @pw, name: "Stephen")
    end

    it "can have many users" do
      o1 = Organization.create(name: "WWF", description: "animal lovers")
      u1 = User.create(email: "b@yahoo.com", password: @pw, name: "Stephen")
      u2 = User.create(email: "c@yahoo.com", password: @pw, name: "Steph")
      expect(o1.user_organizations.new(user: u1).save).to eq true
      expect(o1.user_organizations.new(user: u2).save).to eq true
      expect(o1.users.length).to eq 2
    end

  end
end
