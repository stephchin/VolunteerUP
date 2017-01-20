require 'rails_helper'

RSpec.feature "SignUps", type: :feature do

  before(:each) do
    @organization = Organization.new(name: "ABC", description: "ABC is a helpful org")
    @organization.save
  end

  context "I can go to sign up page" do
    Steps "I can go to the landing page and press the 'Sign-up' button" do
      Given "I am on the landing page" do
        visit '/'
      end
      Then "I can see the sign up page" do
        expect(page).to have_content "Sign up"
      end
      Then "I can press the 'Sign up' button and go to sign up page" do
        click_link('Sign up')
        expect(page).to have_content "Sign up"
      end
      #FYI: testing cannot be done for jquery hide/show
      # Then "I can see that I'm given a default role of 'Volunteer'" do
      #   expect(page).to have_content("Volunteer")
      #   expect(page).to_not have_content("Organization")
      # end
      # And "If I select the Organizer role" do
      #   select "Organizer", from: "role"
      # end
      # Then "I can also see the organizations dropdown" do
      #   expect(page).to_not have_content("Volunteer")
      #   select @organization.name, from: "organization"
      # end
      Then "I can see that a name field is required" do
        fill_in "user[email]", with: "hello@me.com"
        fill_in "user[password]", with: "1234567"
        fill_in "user[password]", with: '1234567'
        click_button "Sign up"
        expect(page).to have_content("Name can't be blank")
      end
      Then "I can fill out the sign-up form as an organizer" do
        fill_in "user[name]", with: "Suzan"
        fill_in "user[city]", with: "Cincinnati"
        fill_in "user[state]", with: "OH"
        fill_in "user[email]", with: "123@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        select "Organizer", from: "role"
        select @organization.name, from: "organization"
        click_button "Sign up"
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
      Then "I can see that I am logged in" do
        expect(page).to have_content("Logged in as: Suzan")
        expect(page).to have_content("Profile")
        expect(page).to have_content("Log out")
        expect(page).to_not have_content("Log in")
        expect(page).to_not have_content("Sign up")
      end
      Then "I can click a button to go to user profile page" do
        click_link "Profile"
        expect(page).to have_content "Hi Suzan!"
        expect(page).to have_content "Email: 123@yahoo.com"
        expect(page).to have_content "Location: Cincinnati OH"
      end
    end
  end
end
