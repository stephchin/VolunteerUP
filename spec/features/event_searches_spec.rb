require 'rails_helper'

RSpec.feature "EventSearches", type: :feature do

  before(:each) do
    @cause = Event.first.cause
    @org = Organization.create(name: "Zzzoooo Org", description: "Zzzzz test org")
    @event = Event.create(name: 'AAA Helpful Fundraiser', description: 'Raising money to help people', cause: @cause, organization: @org, start_time: Time.now, end_time: Time.now+7200, street: '324 NW 23rd St', city: 'Oklahoma City', state: 'CA', postal_code: 73118, volunteers_needed: 10)
    @event2 = Event.first
  end

  context 'Searching for events' do
    Steps 'To search for events' do
      Given 'I am on the events page' do
        visit '/events'
      end
      Then 'I can see the Events header' do
        expect(page).to have_content('Events')
      end
      Then 'I can search for an event by name' do
        fill_in 'filterrific_search_query', with: @event2.name
        click_button 'Search'
      end
      And 'I can see the event(s) I searched for by name, but that\'s all' do
        expect(page).to have_content(@event2.name)
        expect(page).not_to have_content(@event.name)
      end
      Then 'I can search for event by cause' do
        fill_in 'filterrific_search_query', with: @cause
        click_button 'Search'
      end
      Then 'I can see the event(s) I searched for by cause' do
        expect(page).to have_content(@cause)
      end
      Then 'I can sort the events I searched for by date' do
        # click_link 'Reset filters'
        page.select('Date', from: 'filterrific_sorted_by')
        click_button 'Search'
      end
      Then 'I can sort the events I searched for name, ascending' do
        page.select('Event Name (Ascending)', from: 'filterrific_sorted_by')
        click_button 'Search'
      end
      And 'I can see all events in order of name, ascending' do
        expect(page.find('tbody tr:nth-child(1)')).to have_content @event.name
      end
      Then 'I can sort the events I searched for name, descending' do
        page.select('Event Name (Descending)', from: 'filterrific_sorted_by')
        click_button 'Search'
      end
      And 'I can see all events in order of name, descending' do
        # save_and_open_page
        expect(page.find('tbody tr:nth-last-child(1)')).to have_content @event.name
      end
    end
  end
end
