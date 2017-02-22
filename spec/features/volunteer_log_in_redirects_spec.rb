require 'rails_helper'

RSpec.feature "VolunteerLogInRedirects", type: :feature do
  before(:each) do
    @organization = Organization.new(name: "Some Org", description: "ABC is a helpful org")
    @organization.save
    @event = Event.create(name: "Some Event", start_time: DateTime.now + (2.0 / 24.0), end_time: DateTime.now + (5.0 / 24.0), volunteers_needed: 100 )
    @event.organization = @organization
    @event.save
    @user = User.create(name: "Michael", city: "San Diego", state: "CA", email: "1@yahoo.com", password: "123456")
  end

  context "Logged out user cannot volunteer and is redirected to log in area" do
    Steps "Go to root page" do
      Given "I can go the Events page and go to the specific event" do
        visit '/'
        click_link 'Events'
        fill_in 'filterrific_search_query', with: @event.name
        click_button 'Search'
        click_link 'Some Event'
        expect(page).to have_current_path(event_path(@event.id))
      end
      Then "I can click the 'Volunteer!' button and get redirected to log in page" do
        click_link 'Sign in to volunteer'
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_content("You need to sign in or sign up to volunteer.")
      end
    end
  end
end
