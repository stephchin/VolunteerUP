require 'rails_helper'

RSpec.feature "Volunteers", type: :feature do
  context "Users can volunteer for events" do
    Steps "User can go to events page" do
      Given "I have a profile and go to an event page" do
        visit '/'
        click_link('Sign up')
        fill_in "user[name]", with: "Tomas"
        fill_in "user[city]", with: "Rome"
        fill_in "user[state]", with: "Depleted"
        fill_in "user[email]", with: "1@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"

        click_link "Events"
        click_button "New Event"
        fill_in

      end
    end
  end
end
