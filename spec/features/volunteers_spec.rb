require 'rails_helper'

RSpec.feature "Volunteers", type: :feature do
  context "Users can volunteer for events" do
    Steps "User can go to events page" do
      Given "I have a profile and go to an event page" do
        visit '/'
        click_link('Sign up')
        fill_in "user[name]", with: "Tomas"
        fill_in "user[city]", with: "Rome"
        select 'CA', from: 'user_state'
        fill_in "user[email]", with: "1@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
        @user = User.find_by_email("1@yahoo.com")

        click_link "Organizations"
        click_link "New Organization"
        fill_in "organization[name]", with: "Scott's Tots"
        fill_in "organization[description]", with: "Make your dreams come true"
        fill_in "organization[phone]", with: "555-555-5555"
        fill_in "organization[email]", with: "st@yahoo.com"
        fill_in "organization[website]", with: "www.dundermifflin.com"
        click_button "Create Organization"

        visit events_path
        click_link "New Event"
        fill_in "event[name]", with: "Give laptops"
        fill_in "event[description]", with: "We have batteries"
        select "Animals", from: 'event_cause'
        select "2017", from: "event_start_time_1i"
        select "January", from: "event_start_time_2i"
        select "20", from: "event_start_time_3i"
        select "20", from: "event_start_time_4i"
        select "20", from: "event_start_time_5i"
        select "2017", from: "event_end_time_1i"
        select "January", from: "event_end_time_2i"
        select "21", from: "event_end_time_3i"
        select "20", from: "event_end_time_4i"
        select "20", from: "event_end_time_5i"
        fill_in "event[street]", with: "2615 Flagstaff Ct"
        fill_in "event[city]", with: "Chula Vista"
        select 'CA', from: 'event_state'
        fill_in "event[postal_code]", with: "91914"
        fill_in "event[country]", with: "USA"
        fill_in "event[volunteers_needed]", with: 20
        select "Scott's Tots", from: "event_organization_id"
        click_button "Create Event"
        @event = Event.find_by_name("Give laptops")
        expect(page).to have_current_path(event_path(@event.id))
      end
      Then "I am on the events page and can click the 'Volunteer!' button" do
        click_button "Volunteer!"
      end
      Then "I can go to my profile page and see the event" do
        visit user_path(@user)
        expect(page).to have_current_path(user_path(@user.id))
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.events.find(@event.id).name)
      end
      And "I can click the 'Cancel Your RSVP'" do
        visit user_path(@user.id)
        click_link "Cancel Your RSVP"
        within('#user-events-table') do
          expect(page).to_not have_content(Event.find(@event.id).name)
          expect(page).to_not have_content(Event.find(@event.id).description)
          expect(page).to_not have_content(Event.find(@event.id).cause)
        end
      end
    end
  end
end
