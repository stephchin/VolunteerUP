require 'rails_helper'

RSpec.feature "EventSearches", type: :feature do

  # before(:each) do
  #   @user = User.create(name: "Donnie", email: "1@yahoo.com", password: "123456",
  #     city: "San Diego", state: "CA")
  #   @org = Organization.new(name: "The Red Cross", description: "A non-profit organization")
  #   @org.save
  #   @org2 = Organization.new(name: "The Puppy Shelter", description: "A non-profit organization")
  #   @org2.save
  #   @user.organizations << @org << @org2
  # end

  context 'Searching for events' do
    Steps 'To search for events' do
      Given 'I am on the events page' do
        visit '/events'
      end
      Then 'I can see the Events header' do
        expect(page).to have_content('Events')
      end
      Then 'I can search for an event by name' do
        fill_in 'Search', with: 'Blood Drive'
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
