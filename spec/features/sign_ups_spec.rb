require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  context "I can go to sign up page" do
    Steps "I can go to the landing page and press the 'Sign-up' button" do
      Given "I am on the landing page" do
        visit '/users/sign_up'
      end
      Then "I can see the sign up page" do
        expect(page).to have_content "Sign up"
      end
      # Then "I can press the 'Sign-up' button and go to sign up page" do
      #   click_link('Sign-up')
      #   expect(page).to have_content "Sign up"
      # end
      Then "I can fill out form" do
        fill_in "user[email]", with: "123@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
    end
  end
end
