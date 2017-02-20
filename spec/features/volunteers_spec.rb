require 'rails_helper'

RSpec.feature "Volunteers", type: :feature do
  before(:each) do
    @user = User.find_by_email("a@yahoo.com")
    @org = Organization.find_by_name("We Help")
    @event = Event.create(name: "Event1", start_time: DateTime.now , end_time: DateTime.now + (5.0 / 24.0), volunteers_needed: 100, organization: @org )
  end
  context "Users can volunteer for events" do
    Steps "User can go to events page" do
      Given "I have a profile and go to an event page" do
        visit '/'
        click_link('Log in')
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then "I am on the events page and can click the 'Volunteer!' button" do
        visit event_path(@event)
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
        find("a[href*='/events/#{@user.id}/remove_event?event=#{@event.id}']").click
        within('#user-events-table') do
          expect(page).to_not have_content(@event.name)
        end
      end
    end
  end
end
