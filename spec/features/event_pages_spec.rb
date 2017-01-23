require 'rails_helper'

RSpec.feature "EventPages", type: :feature do

  before(:each) do
    @organization = Organization.new(name: "ABC", description: "ABC is a helpful org")
    @organization.save
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 1 )
    @event.organization = @organization
    @event.save
    @user = User.create(name: "Michael", city: "San Diego", state: "CA", email: "1@yahoo.com", password: "123456")
  end

  context 'I can go to the event page' do
    Steps 'I can go to the events page and click on a specific event for further details' do
      Given 'I am on the events page and logged in' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: "1@yahoo.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        visit '/events'
      end
      Then 'I can click the event name' do
        click_link (@event.name)
      end
      Then 'I can see that event\'s page with event info' do
        expect(page).to have_content "#{@event.name}"
        expect(page).to have_content "#{@event.description}"
        expect(page).to have_content "#{@event.organization.name}"
        expect(page).to have_content "#{@event.volunteers_needed}"
      end
      Then 'I have the option to go back to events page' do
        expect(page).to have_link("Back", href: "/events")
      end
      And 'I can click the volunteer button' do
        click_button('Volunteer!')
      end
      And 'I am taken to the user profile page with my upcoming event' do
        expect(page).to have_content "Your Upcoming Events"
        expect(page).to have_content "#{@event.name}"
      end
      Then 'I can click on a link to go back to the events page' do
        click_link "Events"
      end
      And 'The event\'s volunteers needed count goes down' do
        expect(page).to have_content "#{@event.name}"
        expect(page).to have_content "#{@event.volunteers_needed}"
      end
      Then 'I can go back to the event\'s page' do
        click_link (@event.name)
      end
      And 'The event\'s volunteers needed count is updated' do
        expect(page).to have_content "#{@event.volunteers_needed}"
      end
      Then 'I can log out' do
        click_link "Log out"
      end
      And 'I can log in as another user and visit the events page' do
        click_link "Log in"
        fill_in "user[email]", with: "g@yahoo.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        visit '/events'
      end
      Then 'When I try to sign up for a full event, there is no volunteer button' do
        click_link (@event.name)
        expect(page).not_to have_button('Volunteer!')
      end
    end
  end
end
