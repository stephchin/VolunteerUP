require 'rails_helper'

RSpec.feature "Calendars", type: :feature do
  before(:each) do
    @user = User.create(name: "YungTony", email:"t_eazy@bigmoney.com", password:"password", password_confirmation: "password", city: "Cincinnasty", state: "OH" )
    @user.save
    @event = Event.create(name: "Event1", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 100 )
    @organization = Organization.create(name: "ABC", description: "ABC is a helpful org")
    @organization.save
    @organization2 = Organization.create(name: "DEF", description: "DEF is a helpful org")
    @organization2.save

    @user.organizations << @organization
    @user.organizations << @organization2
    @user.save

    @event.organization = @organization
    @event.save
    UserEvent.create(user: @user, event: @event)
  end

  context 'I can see a calendar on the profile page' do
    Steps 'Going to your profile page and viewing the calendar' do
      Given 'I am on my profile page and logged in' do
        visit  '/'
        click_link 'Log in'
        fill_in "user[email]", with: "t_eazy@bigmoney.com"
        fill_in "user[password]", with: "password"
        click_button "Log in"
        visit user_path(@user)
      end
      And 'The event calendar has loaded' do
        page.find("#events_map[data-events-id]")
      end
    #   Then 'I can go to the map locations JSON page' do
    #     visit '/events/map_locations.json'
    #   end
    #   And 'I will see the JSON object includes a lat and long' do
    #     expect(page).to have_content "#{Event.first.latitude}"
    #   end
    # end
  end
end
end
