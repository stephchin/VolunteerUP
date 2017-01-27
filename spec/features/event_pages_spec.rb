require 'rails_helper'

RSpec.feature "EventPages", type: :feature do

  before(:each) do
    @organization = Organization.find_by_name("We Help")
    @organization.save
    @event = Event.create(name: "ABC", cause: "Other", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 1 )
    @event.organization = @organization
    @event.save
    @user = User.find_by_email("a@yahoo.com")
    @user.add_role :volunteer
  end

  context 'I can go to the event page' do
    Steps 'I can go to the events page and click on a specific event for further details' do
      Given 'I am on the events page and logged in' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
        visit '/events'
      end
      Then 'I can click the event name' do
        click_link (@event.name)
      end
      Then 'I can see that event\'s show page with event info' do
        expect(page).to have_content "#{@event.name}"
        within('#cause') do
        expect(page).to have_content "Other"
        end
        expect(page).to have_content "#{@event.description}"
        expect(page).to have_content "#{@event.organization.name}"
        expect(page).to have_content "#{@event.volunteers_needed}"
      end
      And 'I can click the volunteer button' do
        click_button('Volunteer!')
      end
      And 'I can see that I have successfully signed up' do
        expect(page).to have_content('You\'re signed up!')
      end
      Then 'I can go to my user profile page and see my upcoming event' do
        visit user_path(@user)
        expect(page).to have_content "#{@event.name}"
        expect(page).to have_content "Cancel Your RSVP"
      end
      Then 'I can click on a link to go back to the events page' do
        click_link "Events"
      end
      And 'The event\'s volunteers needed count goes down' do
        expect(page).to have_content "#{@event.name}"
        expect(page).to have_content "#{@event.volunteers_needed - 1}"
      end
      Then 'I can go back to the event\'s page' do
        click_link (@event.name)
      end
      And 'The event\'s volunteers needed count is updated' do
        expect(page).to have_content "#{@event.volunteers_needed - 1}"
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
    end
  end
end
