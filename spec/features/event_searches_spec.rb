require 'rails_helper'

RSpec.feature "EventSearches", type: :feature do

  before(:each) do
    @user = User.create(name: "Donnie", email: "1@yahoo.com", password: "123456",
      city: "San Diego", state: "CA")
    @org = Organization.new(name: "The Red Cross", description: "A non-profit organization")
    @org.save
    @org2 = Organization.new(name: "The Puppy Shelter", description: "A non-profit organization")
    @org2.save
    @user.organizations << @org << @org2
  end

  context 'Searching for events' do
    Steps 'To search for events' do
      Given 'I am on the events page, I am logged in, and I am an organizer' do
        visit '/users/sign_in'
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
        expect(page).to have_content "Organizer"
        visit '/events'
        save_and_open_page
      end
      # Then 'I can create a new event' do
      #   click_link 'New Event'
      #   fill_in 'Name', with: 'Blood Drive'
      #   fill_in 'Description', with: 'rad thing'
      #   select '2017', :from => 'event[start_time(1i)]'
      #   select 'January', :from => 'event[start_time(2i)]'
      #   select '26', :from => 'event[start_time(3i)]'
      #   select '12', :from => 'event[start_time(4i)]'
      #   select '30', :from => 'event[start_time(5i)]'
      #   select '2017', :from => 'event[end_time(1i)]'
      #   select 'January', :from => 'event[end_time(2i)]'
      #   select '26', :from => 'event[end_time(3i)]'
      #   select '02', :from => 'event[end_time(4i)]'
      #   select '30', :from => 'event[end_time(5i)]'
      #   select @org.name, from: "event_organization_id"
      #   fill_in 'Volunteers needed', with: '100'
      #   click_button 'Create Event'
      # end
      # And 'I can see the event was successfully created' do
      #   expect(page).to have_content('Event was successfully created.')
      # end
      # Then 'I can go back to the events page' do
      #   click_link 'Back'
      #   expect(page).to have_content('Blood Drive')
      # end
      # And 'I can create a 2nd new event' do
      #   click_link 'New Event'
      #   fill_in 'Name', with: 'Food Donation'
      #   fill_in 'Cause', with: 'just cause'
      #   select '2017', :from => 'event[start_time(1i)]'
      #   select 'February', :from => 'event[start_time(2i)]'
      #   select '26', :from => 'event[start_time(3i)]'
      #   select '12', :from => 'event[start_time(4i)]'
      #   select '30', :from => 'event[start_time(5i)]'
      #   select '2017', :from => 'event[end_time(1i)]'
      #   select 'February', :from => 'event[end_time(2i)]'
      #   select '26', :from => 'event[end_time(3i)]'
      #   select '02', :from => 'event[end_time(4i)]'
      #   select '30', :from => 'event[end_time(5i)]'
      #   select @org2.name, from: "event_organization_id"
      #   fill_in 'Volunteers needed', with: '100'
      #   click_button 'Create Event'
      # end
      # And 'I can see event 2 was successfully created' do
      #   expect(page).to have_content('Event was successfully created.')
      # end
      # Then 'I can go back to the events page, with event 2 listed' do
      #   click_link 'Back'
      #   expect(page).to have_content('Food Donation')
      # end
      # And 'I can create a 3rd new event' do
      #   click_link 'New Event'
      #   fill_in 'Name', with: 'Canned Food Event'
      #   select '2017', :from => 'event[start_time(1i)]'
      #   select 'March', :from => 'event[start_time(2i)]'
      #   select '26', :from => 'event[start_time(3i)]'
      #   select '12', :from => 'event[start_time(4i)]'
      #   select '30', :from => 'event[start_time(5i)]'
      #   select '2017', :from => 'event[end_time(1i)]'
      #   select 'March', :from => 'event[end_time(2i)]'
      #   select '26', :from => 'event[end_time(3i)]'
      #   select '02', :from => 'event[end_time(4i)]'
      #   select '30', :from => 'event[end_time(5i)]'
      #   select @org.name, from: "event_organization_id"
      #   fill_in 'City', with: 'San Diego'
      #   fill_in 'Volunteers needed', with: '100'
      #   click_button 'Create Event'
      # end
      # And 'I can see the event was successfully created' do
      #   expect(page).to have_content('Event was successfully created.')
      # end
      # Then 'I can go back to the events page, with the new event listed' do
      #   click_link 'Back'
      #   expect(page).to have_content('Canned Food Event')
      # end
      Then 'I can search for an event by name' do
        fill_in 'Search', with: 'Drive'
        1/0
        click_button 'Search'
        save_and_open_page
      end
      And 'I can see the thing(s) I searched for by name, but that\'s all' do
        expect(page).to have_content('Blood Drive')
        expect(page).not_to have_content('Food Donation')
        expect(page).not_to have_content('Canned Food Event')
      end
      Then 'I can search for event by cause' do
        fill_in 'Search', with: 'just cause'
        click_button 'Search'
      end
      Then 'I can see the event(s) I searched for by cause, but that\'s all' do
        expect(page).to have_content('just cause')
        expect(page).not_to have_content('Canned Food Event')
      end
      Then 'I can search for event by any part of an address' do
        fill_in 'Search', with: 'San Diego'
        click_button 'Search'
      end
      Then 'I can see the event(s) I searched for by address, but that\'s all' do
        expect(page).to have_content('San Diego')
        expect(page).not_to have_content('Blood Drive')
      end
      Then 'I can search for event by org name' do
        fill_in 'Search', with: 'The Red Cross'
        click_button 'Search'
      end
      Then 'I can see the event(s) I searched for by organization, but that\'s all' do
        expect(page).to have_content('The Red Cross')
        expect(page).not_to have_content('Food Donation')
      end
      Then 'I can filter events searched for that start after a certain date, but that\'s all' do
        page.select('2017', from: 'start_time_year')
        page.select('February', from: 'start_time_month')
        page.select('1', from: 'start_time_day')
        click_button 'Search'
      end
      And 'I can see the event(s) I searched for that start after a certain date' do
        expect(page).to have_content('Canned Food Event')
        expect(page).not_to have_content('Blood Drive')
        expect(page).not_to have_content('Food Donation')
      end
      Then 'I can go back to the events index and filter events after a certain date without searching for a name' do
        visit '/events'
        page.select('2017', from: 'start_time_year')
        page.select('February', from: 'start_time_month')
        page.select('1', from: 'start_time_day')
        click_button 'Search'
        save_and_open_page
      end
    end
  end
end
