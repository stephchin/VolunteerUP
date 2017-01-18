require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "Event" do
    it "has to be real" do
      expect{Event.new}.to_not raise_error
    end
    it "has a name" do
      new_event = Event.new
      new_event.name = "ABC"
      expect(new_event.name).to eq "ABC"
    end
    it "has a description" do
      new_event = Event.new
      new_event.description = "a non profit org"
      expect(new_event.description).to eq "a non profit org"
    end
    it "has a start time" do
      new_event = Event.new
      new_event.start_time = DateTime.new(2017,1,18,1,30)
      expect(new_event.start_time.year).to eq 2017
      expect(new_event.start_time.month).to eq 1
      expect(new_event.start_time.day).to eq 18
      expect(new_event.start_time.hour).to eq 1
      expect(new_event.start_time.min).to eq 30
    end
    it "has a end time" do
      new_event = Event.new
      new_event.end_time = DateTime.new(2017,1,18,5,30)
      expect(new_event.end_time.year).to eq 2017
      expect(new_event.end_time.month).to eq 1
      expect(new_event.end_time.day).to eq 18
      expect(new_event.end_time.hour).to eq 5
      expect(new_event.end_time.min).to eq 30
    end
    it "has a number of volunteers needed" do
      new_event = Event.new
      new_event.volunteers_needed = 100
      expect(new_event.volunteers_needed).to eq 100
    end
    it "should save" do
      new_event = Event.new(name: "ABC", start_time: DateTime.new(2017,1,18,1,30), end_time: DateTime.new(2017,1,18,5,30), volunteers_needed: 100)
      expect{new_event.save}.to_not raise_error
    end
  end
end
