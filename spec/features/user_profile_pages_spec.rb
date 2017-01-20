require 'rails_helper'

RSpec.feature "UserProfilePages", type: :feature do
  before(:each) do
    @user = User.create(name: "YungTony", email:"t_eazy@bigmoney.com", password:"password", password_confirmation: "password", city: "Cincinnasty", state: "OH" )
    @user.save
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 100 )
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

  context 'I can go to the user profile page' do
    Steps 'I can go to user profile page to see user details' do
      Given 'I am on my profile page and logged in' do
        visit  '/'
        click_link 'Log in'
        fill_in "user[email]", with: "t_eazy@bigmoney.com"
        fill_in "user[password]", with: "password"
        click_button "Log in"
        visit user_path(@user)
      end
      Then 'I can see my profile information' do
        expect(page).to have_content @user.name
        expect(page).to have_content @user.email
        expect(page).to have_content @user.city
        expect(page).to have_content @user.state
      end
      And "I can see a link to edit my profile info" do
        expect(page).to have_link "Account Settings"
      end
      And "I can see a list of my Organizations" do
        save_and_open_page
        expect(page).to have_content @organization.name
        expect(page).to have_content @organization2.name
      end
      And "I can see a list of my RSVP'd events" do
        expect(page).to have_content @event.name
      end
    end
  end
end
