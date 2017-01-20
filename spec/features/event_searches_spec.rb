require 'rails_helper'

RSpec.feature "EventSearches", type: :feature do

  before(:each) do
    @org = Organization.new(name: "The Red Cross", description: "A non-profit organization")
    @org.save
    @org2 = Organization.new(name: "The Puppy Shelter", description: "A non-profit organization")
    @org2.save
  end

  context 'Searching for events' do
    Steps 'To search for events' do
      Given 'I am on the events page' do
        visit '/events'
      end
      Then 'I can create a new event' do
        click_link 'New Event'
        fill_in 'Name', with: 'test'
        fill_in 'Description', with: 'rad thing'
        select '2019', :from => 'event[start_time(1i)]'
        select 'January', :from => 'event[start_time(2i)]'
        select '26', :from => 'event[start_time(3i)]'
        select '12', :from => 'event[start_time(4i)]'
        select '30', :from => 'event[start_time(5i)]'
        select '2019', :from => 'event[end_time(1i)]'
        select 'January', :from => 'event[end_time(2i)]'
        select '26', :from => 'event[end_time(3i)]'
        select '02', :from => 'event[end_time(4i)]'
        select '30', :from => 'event[end_time(5i)]'
        select @org.name, from: "event_organization_id"
        fill_in 'Volunteers needed', with: '100'
        click_button 'Create Event'
      end
      And 'I can see the event was successfully created' do
        expect(page).to have_content('Event was successfully created.')
      end
      Then 'I can go back to the events page' do
        click_link 'Back'
        expect(page).to have_content('test')
      end
      And 'I can create a 2nd new event' do
        click_link 'New Event'
        fill_in 'Name', with: 'test2'
        fill_in 'Cause', with: 'just cause'
        select '2019', :from => 'event[start_time(1i)]'
        select 'February', :from => 'event[start_time(2i)]'
        select '26', :from => 'event[start_time(3i)]'
        select '12', :from => 'event[start_time(4i)]'
        select '30', :from => 'event[start_time(5i)]'
        select '2019', :from => 'event[end_time(1i)]'
        select 'February', :from => 'event[end_time(2i)]'
        select '26', :from => 'event[end_time(3i)]'
        select '02', :from => 'event[end_time(4i)]'
        select '30', :from => 'event[end_time(5i)]'
        select @org2.name, from: "event_organization_id"
        fill_in 'Volunteers needed', with: '100'
        click_button 'Create Event'
      end
      And 'I can see event 2 was successfully created' do
        expect(page).to have_content('Event was successfully created.')
      end
      Then 'I can go back to the events page, with event 2 listed' do
        click_link 'Back'
        expect(page).to have_content('test2')
      end
      And 'I can create a 3rd new event' do
        click_link 'New Event'
        fill_in 'Name', with: 'example'
        select '2019', :from => 'event[start_time(1i)]'
        select 'March', :from => 'event[start_time(2i)]'
        select '26', :from => 'event[start_time(3i)]'
        select '12', :from => 'event[start_time(4i)]'
        select '30', :from => 'event[start_time(5i)]'
        select '2019', :from => 'event[end_time(1i)]'
        select 'March', :from => 'event[end_time(2i)]'
        select '26', :from => 'event[end_time(3i)]'
        select '02', :from => 'event[end_time(4i)]'
        select '30', :from => 'event[end_time(5i)]'
        select @org.name, from: "event_organization_id"
        fill_in 'City', with: 'San Diego'
        fill_in 'Volunteers needed', with: '100'
        click_button 'Create Event'
      end
      And 'I can see the event was successfully created' do
        expect(page).to have_content('Event was successfully created.')
      end
      Then 'I can go back to the events page, with the new event listed' do
        click_link 'Back'
        expect(page).to have_content('example')
      end
      Then 'I can search for an event by name' do
        fill_in 'Search', with: 'test'
        click_button 'Search All'
      end
      And 'I can see the thing(s) I searched for by name, but that\'s all' do
        expect(page).to have_content('test')
        expect(page).to have_content('test2')
        expect(page).not_to have_content('example')
      end
      Then 'I can search for an event by description' do
        fill_in 'Search', with: 'rad thing'
        click_button 'Search All'
      end
      Then 'I can see the event(s) I searched for by description, but that\'s all' do
        expect(page).to have_content('rad thing')
        expect(page).not_to have_content('example')
      end
      Then 'I can search for event by cause' do
        fill_in 'Search', with: 'just cause'
        click_button 'Search All'
      end
      Then 'I can see the event(s) I searched for by cause, but that\'s all' do
        expect(page).to have_content('just cause')
        expect(page).not_to have_content('example')
      end
      Then 'I can serach for event by any part of an address' do
        fill_in 'Search', with: 'San Diego'
        click_button 'Search All'
      end
      Then 'I can see the event(s) I searched for by address, but that\'s all' do
        expect(page).to have_content('San Diego')
        expect(page).not_to have_content('test')
      end
      Then 'I can search for event by org name' do
        fill_in 'Search', with: 'The Red Cross'
        click_button 'Search All'
      end
      Then 'I can see the event(s) I searched for by organization, but that\'s all' do
        expect(page).to have_content('The Red Cross')
        expect(page).not_to have_content('test2')
      end
    end
  end
end
