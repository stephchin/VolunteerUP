require 'rails_helper'

RSpec.feature "EventPages", type: :feature do

  before(:each) do
    
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 100 )
  end
  context 'I can go to the event page' do
    Steps 'I can go to the events page and click on a speciifc event for further details' do
      Given 'I am on the events page' do
        visit events_path
      end
      Then 'I can click the event name' do
        click_link (@event.name)
      end
      Then 'I am taken to the event page' do
        visit event_path(@event)
      end
      Then 'I can view the event details' do
        expect(page).to have_content("Description:")
        expect(page).to have_content("Cause:")
        expect(page).to have_content("Date and Time:")
        expect(page).to have_content("Address:")
        expect(page).to have_content("Volunteers needed:")
      end
      And 'I can click the volunteer button' do
        click_button('Volunteer!')
      end
    end
  end
end
