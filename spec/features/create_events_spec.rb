require 'rails_helper'

RSpec.feature "CreateEvents", type: :feature do

  before(:each) do
    @org = Organization.new(name: "The Red Cross", description: "A non-profit organization")
    @org.save
  end

  context "I can go to the events page" do
    Steps "I can go to the events page" do
      Given "I have an account" do
        visit '/users/sign_up'
        fill_in "user[name]", with: 'Stephanie'
        fill_in "user[city]", with: 'San Francisco'
        fill_in "user[state]", with: 'CA'
        fill_in "user[email]", with: '1@yahoo.com'
        fill_in "user[password]", with: '123456'
        fill_in "user[password_confirmation]", with: '123456'
        click_button "Sign up"
      end
      And "I am on the Events Page" do
        visit '/events'
      end
      Then "I can click the New Event button" do
        click_link 'New Event'
        expect(page).to have_content "New Event"
      end
      Then "I can fill in event information" do
        fill_in "event[name]", with: 'Adopt-A-Puppy'
        fill_in "event[description]", with: 'Puppy adoption'
        select '2017', from: 'event_start_time_1i'
        select 'January', from: 'event_start_time_2i'
        select '18', from: 'event_start_time_3i'
        select '01', from: 'event_start_time_4i'
        select '30', from: 'event_start_time_5i'
        select '2017', from: 'event_end_time_1i'
        select 'January', from: 'event_end_time_2i'
        select '18', from: 'event_end_time_3i'
        select '03', from: 'event_end_time_4i'
        select '30', from: 'event_end_time_5i'
        fill_in "event[street]", with: '704 J St'
        fill_in "event[city]", with: 'San Diego'
        fill_in "event[state]", with: 'CA'
        fill_in "event[postal_code]", with: '92101'
        fill_in "event[country]", with: 'USA'
        fill_in "event[volunteers_needed]", with: '100'
        select @org.name, from: "event_organization_id"
        click_button "Create Event"
      end
      And "I can see the success message" do
        expect(page).to have_content "Adopt-A-Puppy"
      end
    end
  end
end
