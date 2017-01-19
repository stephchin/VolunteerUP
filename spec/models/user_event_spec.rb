require 'rails_helper'
RSpec.describe UserEvent, type: :model do

  before(:each) do
    @start = DateTime.new(2017,1,18,1,30)
    @end = DateTime.new(2017,1,18,5,30)
    @pw = "123456"
  end

  describe "User" do
    it "can be created and saved" do
      u1 = User.create(email: "a@yahoo.com", password: @pw)
      e1 = Event.create(name: "Blood", start_time: @start, end_time: @end,
        volunteers_needed: 10)
      e2 = Event.create(name: "Pestilence", start_time: @start, end_time: @end,
        volunteers_needed: 100)
    end

    it "can have many events" do
      u1 = User.create(email: "a@yahoo.com", password: @pw)
      e1 = Event.create(name: "Blood", start_time: @start, end_time: @end,
        volunteers_needed: 10)
      e2 = Event.create(name: "Pestilence", start_time: @start, end_time: @end,
        volunteers_needed: 100)
      expect(u1.user_events.new(event: e1).save).to eq true
      expect(u1.user_events.new(event: e2).save).to eq true
      expect(u1.user_events.all.length).to eq 2
    end
  end

  describe "Event" do

    it "can be created and saved" do
      e1 = Event.create(name: "Frost", start_time: @start, end_time: @end)
      u1 = User.create(email: "b@yahoo.com", password: @pw)
      u2 = User.create(email: "c@yahoo.com", password: @pw)
    end

    it "can have many users" do
      e1 = Event.create(name: "Frost", start_time: @start, end_time: @end,
        volunteers_needed: 30)
      u1 = User.create(email: "b@yahoo.com", password: @pw)
      u2 = User.create(email: "c@yahoo.com", password: @pw)
      expect(e1.user_events.new(user: u1).save).to eq true
      expect(e1.user_events.new(user: u2).save).to eq true
      expect(e1.user_events.all.length).to eq 2
    end

  end
end
