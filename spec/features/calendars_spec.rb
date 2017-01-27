require 'rails_helper'

RSpec.feature "Calendars", type: :feature do

  before(:each) do
    @user = User.create(name: "YungTony", email:"t_eazy@bigmoney.com", password:"password", password_confirmation: "password", city: "Cincinnasty", state: "OH" )
    @user.save
    @event = Event.create(name: "Event1", start_time:"2017-01-01 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 100 )
    @event.save
    @organization = Organization.create(name: "ABC", description: "ABC is a helpful org")
    @organization.save

    @user.organizations << @organization
    @user.save

    @event.organization = @organization
    @event.save
    UserEvent.create(user: @user, event: @event)
  end

  context 'I can see a calendar on my profile page' do
    Steps 'Going to your profile page and viewing the calendar' do
      Given 'I am on my profile page and logged in' do
        visit  '/'
        click_link 'Log in'
        fill_in "user[email]", with: "t_eazy@bigmoney.com"
        fill_in "user[password]", with: "password"
        click_button "Log in"
        visit user_path(@user)
        expect(page).to have_content(@user.name)
      end
      And 'The event calendar has loaded' do
        page.find("#calendar")
      end
      Then 'I can click on the specific event' do
        visit '/users/' + @user.id.to_s + '/get_events'
        expect(page).to have_content(@event.name)
      end
    end
  end
end
