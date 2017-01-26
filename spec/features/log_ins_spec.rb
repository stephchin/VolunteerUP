require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  context "I can go to login page" do
    Steps "I can go to the landing page and press the 'Log in' button" do
      Given "I am on the landing page" do
        visit '/'
      end
      And "I have an account" do
        visit '/users/sign_up'
        fill_in "user[name]", with: 'Stephanie'
        fill_in "user[city]", with: 'San Francisco'
        select 'CA', from: "user_state"
        fill_in "user[email]", with: '1@yahoo.com'
        fill_in "user[password]", with: '123456'
        fill_in "user[password_confirmation]", with: '123456'
        click_button "Sign up"
      end
      Then "I can press the 'Log out' button" do
        click_link('Log out')
        expect(page).to have_content "You've signed out successfully."
      end
      Then "I can Log in" do
        click_link('Log in')
        fill_in "user[email]", with: '1@yahoo.com'
        fill_in "user[password]", with: '123456'
        click_button "Log in"
      end
      And "I can see the success message" do
        expect(page).to have_content "You're logged in and ready to volunteer!"
      end
    end
  end
end
