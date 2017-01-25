require 'rails_helper'

RSpec.feature "Maps", type: :feature do

  before(:each) do
    @organization = Organization.new(name: "ABC", description: "ABC is a helpful org")
    @organization.save
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 1,)
    @event.organization = @organization
    @event.save
    @user = User.find_by_email("a@yahoo.com")
    @user.add_role :volunteer
  end

  context 'I can see a map on the events page' do
    Steps 'Going to the events page and viewing the map' do
      Given 'I am on the events page' do
        visit '/events'
      end
      And 'The map has loaded' do
        page.find("#events_map[data-events-id]")
      end
      Then 'I can go to the map locations JSON page' do
        visit '/events/map_locations.json'
      end
      And 'I will see the JSON object includes a lat and long' do
        expect(page).to have_content "#{Event.first.latitude}"
      end
    end
  end
end
