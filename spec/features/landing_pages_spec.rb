require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'Going to the landing page' do
    Steps 'Go to landing page' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can see a description of the service' do
        expect(page).to have_content('VolunteerUP')
      end
      And 'I can see the navigation bar' do
        expect(page).to have_link(:href=>"/about")
        expect(page).to have_link(:href=>"/events")
        expect(page).to have_link(:href=>"/organizations")
      end
      Then 'I can click the sign up link to take me to a sign up page' do
        click_button('Start Volunteering')
      end
      And 'I will see the registration fields' do
        expect(page).to have_current_path(new_user_registration_path)
      end
      Then 'I can click on the logo to go back to the landing page' do
        click_link('VolunteerUP')
      end
      And 'I will be on the home page again' do
        expect(page).to have_current_path(root_path)
      end
      Then 'I can click the log in link' do
        click_link('Log in')
      end
      And 'I am taken to the log in page' do
        expect(page).to have_current_path(user_session_path)
      end
      Given 'We are on the landing page' do
        visit '/'
      end
      Then 'I can click the events link' do
        click_link('Events')
      end
      And 'I can click link and go to events page' do
        expect(page).to have_content('Events')
      end
      Then 'I can click the organizations link' do
        click_link('Organizations')
      end
      And 'I can click link and go to organizations page' do
        expect(page).to have_content('Organizations')
      end
    end
  end

  before(:each) do
    @user = User.create(name: "Michael", city: "San Diego", state: "CA", email: "1@yahoo.com", password: "123456")
  end
  context 'Going to the landing page as a logged in User' do
    Steps 'Go to landing page' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can login' do
        click_link('Log in')
        fill_in "user[email]", with: '1@yahoo.com'
        fill_in "user[password]", with: '123456'
        click_button "Log in"
      end
      And 'I can see my user dashboard page' do
        expect(page).to have_content "#{@user.email}"
        expect(page).to have_content "Your Upcoming Events"
        expect(page).to have_content "My Roles"
        expect(page).to have_content "My Organization"
      end
    end
  end

end
