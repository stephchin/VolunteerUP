require 'rails_helper'

RSpec.feature "Maps", type: :feature do

  before(:each) do
    @organization = Organization.new(name: "Test Org", description: "Test Org is a helpful org")
    @organization.save
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 1, latitude: 30, longitude: 30)
    @event.organization = @organization
    @event.save
    @user = User.find_by_email("a@yahoo.com")
    @user.add_role :volunteer
    @event2 = Event.create(name: "CBA", start_time:"2017-03-03 01:01:01", end_time:"2017-03-03 02:01:01", volunteers_needed: 1, latitude: 40, longitude: 40)
    @event2.organization = @organization
    @event2.save
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
        visit '/events/map_locations'
      end
      And 'I will see the JSON object includes a lat and long' do
        expect(page).to have_content "#{Event.first.latitude}"
      end
    end
  end

  context 'As a user I can see a map with my events only on my profile page' do
    Steps 'Logging in and going to my profile page' do
      Given 'I am logged in' do
        visit '/users/sign_in'
        fill_in 'Email', with: "a@yahoo.com"
        fill_in 'Password', with: "123456"
        click_button 'Log in'
        expect(page).to have_content("Hi #{@user.name}")
      end
      Then 'I can sign up for an event' do
        visit '/events'
        click_link 'ABC'
        click_button 'Volunteer!'
        expect(page).to have_content("You're signed up!")
      end
      Then 'The user map JSON page has my event, and no others' do
        visit user_path(@user.id) + "/user_map_locations"
        expect(page).to have_content "#{@event.latitude}"
        expect(page).to_not have_content "#{@event2.latitude}"
      end
    end
  end
end
