require 'rails_helper'

RSpec.feature "UserCancelAccounts", type: :feature do
  before(:each) do
    @u1 = User.find_by_email("a@yahoo.com")
  end

  context 'I can cancel my account' do
    Steps 'I can go to my profile page' do
      Given 'I am logged in' do
        visit  '/users/sign_in'
        fill_in "user[email]", with: @u1.email
        fill_in "user[password]", with: '123456'
        click_button "Log in"
      end
      Then 'I can go to my profile page' do
        visit user_path(@u1)
        expect(page).to have_content("Hi Ally")
      end
      Then 'I can go to my account settings' do
        click_link 'Account Settings'
        expect(page).to have_content("Edit User")
      end
      And 'I can click a button to cancel my account' do
        click_button 'Cancel my account'
      end
      # Then "I can click the OK button on the alert" do
      #   @browser.alert.ok
      # end
      Then "I am taken to the homepage where I can sign up again" do
        expect(page).to have_current_path('/')
        expect(page).to have_content('Sign up')
      end
      # And "I can see a list of my RSVP'd events" do
      #   expect(page).to have_content @event.name
      # end
    end
  end
end
