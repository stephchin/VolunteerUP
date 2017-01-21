require 'rails_helper'

RSpec.feature "Volunteers", type: :feature do
  context "Users can volunteer for events" do
    Steps "User can go to events page" do
      Given "I have a profile and go to an event page" do
        visit '/'
        click_link('Sign up')
        fill_in "user[name]", with: "Tomas"
        fill_in "user[city]", with: "Rome"
        fill_in "user[state]", with: "Depleted"
        fill_in "user[email]", with: "1@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"

        click_link "Organizations"
        click_link "New Organization"
        fill_in "organization[name]", with: "Scott's Tots"
        fill_in "organization[description]", with: "Make your dreams come true"
        fill_in "organization[phone]", with: "555-555-5555"
        fill_in "organization[email]", with: "st@yahoo.com"
        fill_in "organization[website]", with: "www.dundermifflin.com"
        click_button "Create Organization"

        click_link "Events"
        click_link "New Event"
        fill_in "event[name]", with: "Give laptops"
        fill_in "event[description]", with: "We have batteries"
        fill_in "event[cause]", with: "For the new high school graduates"
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
        fill_in "event[state]", with: "CA"
        fill_in "event[postal_code]", with: "91914"
        fill_in "event[country]", with: "USA"
        fill_in "event[volunteers_needed]", with: 20
        select "Scott's Tots", from: "event_organization_id"
        click_button "Create Event"
      end

      Then "I am on the events page and can click the 'Volunteer!' button" do
        expect(page).to have_content("Give laptops")
        click_button "Volunteer!"
        expect(page).to have_content("Hi Tomas!")
        expect(page).to have_content("1@yahoo.com")
        expect(page).to have_content("Rome Depleted")
        expect(page).to have_content("Give laptops")
      end
      And "I can click the 'Cancel Your RSVP'" do
        click_link "Cancel Your RSVP"
        expect(page).to_not have_content("Give laptops")
        expect(page).to_not have_content("We have batteries!")
        expect(page).to_not have_content("For the new high school graduates")
      end
    end
  end
end
