require 'rails_helper'

RSpec.feature "EventPages", type: :feature do

  before(:each) do
    @organization = Organization.new(name: "ABC", description: "ABC is a helpful org")
    @organization.save
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 100 )
    @event.organization = @organization
    @event.save
    @user = User.create(name: "Michael", city: "San Diego", state: "CA", email: "1@yahoo.com", password: "123456")
  end

  context 'I can go to the event page' do
    Steps 'I can go to the events page and click on a speciifc event for further details' do
      Given 'I am on the events page and logged in' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: "1@yahoo.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        visit '/events'
      end
      Then 'I can click the event name' do
        click_link (@event.name)
      end
      Then 'I am taken to the event page' do
        visit event_path(@event)
      end
      Then 'I can view the event information' do
        expect(page).to have_content
      end
      And 'I can click the volunteer button' do
        click_button('Volunteer!')
      end
    end
  end
end
