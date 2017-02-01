require 'rails_helper'

RSpec.feature "Breadcrumbs", type: :feature do

  before(:each) do
    @organization = Organization.find_by_name("We Help")
    @event = Event.new(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 1)
    @event.organization = @organization
    @event.save
  end

  context 'Breadcrumbs show navigation path' do
    Steps 'Using breadcrumbs to navigate' do
      Given 'I am on the Clothes Drive event page' do
        visit event_path(@event.id) 
      end
      Then 'I can see a link back to the Events page' do
        expect(page).to have_selector(:link_or_button, 'Events')
      end
      And 'I can click the Events link' do
        click_link ('Events')
      end
      Then 'I can see the Events page with events list' do
        expect(page).to have_current_path(events_path)
      end
      And 'I can see a link back to the Home page' do
        expect(page).to have_selector(:link_or_button, 'Home')
      end
      And 'I can click the Home link' do
        click_link ('Home')
      end
      Then 'I can see the Home page' do
        expect(page).to have_current_path(root_path)
      end
    end
  end
end
