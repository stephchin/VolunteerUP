require 'rails_helper'

RSpec.feature "EventSearches", type: :feature do
  context 'Creating multiple events' do
    Steps 'To create events' do
      Given 'I am on the events page' do
        visit '/events'
      end
      Then 'I can click the new event button' do
        click_link 'New Event'
      end
      And 'I am taken to a new event page' do
        expect(page).to have_content('Volunteers needed Back')
      end
      Then 'I can fill in the info' do
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
        fill_in 'Volunteers needed', with: '100'
      end
      And 'I can submit the info' do
        click_button 'Create Event'
      end
      Then 'I can see the event was successfully created' do
        expect(page).to have_content('Event was successfully created.')
      end
      Then 'I can click on the link to go back' do
        click_link 'Back'
      end
      And 'I am back on the events listing page, with the new event listed' do
        expect(page).to have_content('test')
      end
      Then 'I can click the new event button' do
        click_link 'New Event'
      end
      And 'I am taken to a new event page' do
        expect(page).to have_content('Volunteers needed Back')
      end
      Then 'I can fill in the info for event 2' do
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
        fill_in 'Volunteers needed', with: '100'
      end
      And 'I can submit event 2 info' do
        click_button 'Create Event'
      end
      Then 'I can see event 2 was successfully created' do
        expect(page).to have_content('Event was successfully created.')
      end
      Then 'I can click on the link to go back' do
        click_link 'Back'
      end
      And 'I am back on the events listing page, with event 2 listed' do
        expect(page).to have_content('test2')
      end
      Then 'I can click the new event button' do
        click_link 'New Event'
      end
      And 'I am taken to a new event page' do
        expect(page).to have_content('Volunteers needed Back')
      end
      Then 'I can fill in the info' do
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
        fill_in 'City', with: 'San Diego'
        fill_in 'Volunteers needed', with: '100'
      end
      And 'I can submit the info' do
        click_button 'Create Event'
      end
      Then 'I can see the event was successfully created' do
        expect(page).to have_content('Event was successfully created.')
      end
      Then 'I can click on the link to go back' do
        click_link 'Back'
      end
      And 'I am back on the events listing page, with the new event listed' do
        expect(page).to have_content('example')
      end
      Then 'I can enter a name into a search box' do
        fill_in 'Search', with: 'test'
      end
      And 'I can click the search button' do
        click_button 'Search All'
      end
      Then 'I can see the thing(s) I searched for by name, but that\'s all' do
        expect(page).to have_content('test')
        expect(page).to have_content('test2')
        expect(page).not_to have_content('example')
      end
      Then 'I can enter a description into a search box' do
        fill_in 'Search', with: 'rad thing'
      end
      And 'I can click the search button' do
        click_button 'Search All'
      end
      Then 'I can see the thing(s) I searched for by description, but that\'s all' do
        expect(page).to have_content('rad thing')
        expect(page).not_to have_content('example')
      end
      Then 'I can enter a cause into a search box' do
        fill_in 'Search', with: 'just cause'
      end
      And 'I can click the search button' do
        click_button 'Search All'
      end
      Then 'I can see the thing(s) I searched for by cause, but that\'s all' do
        expect(page).to have_content('just cause')
        expect(page).not_to have_content('example')
      end
      Then 'I can enter any part of an address into a search box' do
        fill_in 'Search', with: 'San Diego'
      end
      And 'I can click the search button' do
        click_button 'Search All'
      end
      Then 'I can see the thing(s) I searched for by address, but that\'s all' do
        expect(page).to have_content('San Diego')
        expect(page).not_to have_content('test')
      end
    end
  end
end
