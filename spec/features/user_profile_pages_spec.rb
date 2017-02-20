require 'rails_helper'

RSpec.feature "UserProfilePages", type: :feature do
  before(:each) do
    @user = User.find_by_email("a@yahoo.com")
    @event = Event.create(name: "Event1", start_time: DateTime.now + (2.0 / 24.0), end_time: DateTime.now + (5.0 / 24.0), volunteers_needed: 100 )
    @o1 = Organization.find_by_name("We Help")
    @o2 = Organization.find_by_name("Food Bankers")
    @user.organizations << @o1
    @user.organizations << @o2
    @user.save
    @event.organization = @o1
    @event.save
    UserEvent.create(user: @user, event: @event)
  end

  context 'I can go to the user profile page' do
    Steps 'I can go to user profile page to see user details' do
      Given 'I am on my profile page and logged in' do
        visit  '/'
        click_link 'Log in'
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        visit user_path(@user)
      end
      Then 'I can see my profile information' do
        expect(page).to have_content @user.name
        expect(page).to have_content @user.email
        expect(page).to have_content @user.city
        expect(page).to have_content @user.state
      end
      And 'I can see a link to edit my profile info' do
        expect(page).to have_link "My Settings"
      end
      And 'I can see a list of my Organizations' do
        expect(page).to have_content @o1.name
        expect(page).to have_content @o2.name
      end
      And 'I can see a list of my RSVP\'d events' do
        expect(page).to have_content @event.name
      end
      And 'I can click on my organization name to go to its page' do
          within('#user-events-table') do
          expect(page).to have_link @o1.name
          visit organization_path(@o1)
          end
        expect(page).to have_current_path(organization_path(@o1.id))
      end
      And 'I can see a calendar of events that I am attending' do
        page.has_selector?('calendar', :text => 'Calendar', :visible => true)
      end
      Then 'I can click on the specific event on the calendar' do
        visit '/users/' + @user.id.to_s + '/get_events'
        expect(page).to have_content(@event.name)
      end
    end
  end
end
