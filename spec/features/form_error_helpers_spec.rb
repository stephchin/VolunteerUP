require 'rails_helper'

RSpec.feature "FormErrorHelpers", type: :feature do

  before(:each) do
    @u = User.find_by_email("a@yahoo.com")
    @pw = "123456"
    @org = Organization.first
    @u.user_organizations.create(organization: @org, is_creator: true)
  end

  context "Seeing Form Errors on Sign Up" do
    Steps "Go to the sign up page" do
      Given "I am on the sign up page and haven't filled in any fields" do
        visit '/users/sign_up'
      end
      Then "I can click the 'Sign up' button" do
        click_button('Sign up')
      end
      And "I can see errors for the required fields" do
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end
      And "If I fill out a password that is less than 6 characters" do
        fill_in "user[name]", with: "Hello"
        fill_in "user[email]", with: "hello@me.com"
        fill_in "user[password]", with: "abc"
        fill_in "user[password]", with: 'abc'
        click_button "Sign up"
      end
      Then "I see an error message that my password is too short" do
        expect(page).to have_content("Password is too short (minimum is 6 characters)")
      end
    end
  end

  context "Seeing Form Errors on Event Form" do
    Steps "Going to the events form" do
      Given "I am logged in as an organizer" do
        visit new_user_session_path
        fill_in "user[email]", with: @u.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
      end
      Then "I can go to the events index" do
        visit events_path
      end
      And "I can click a button to create an event" do
        click_link "New Event"
      end
      And "If I haven't filled in the required fields then I see an error" do
        click_button "Create Event"
      end
      And "I can see errors for the required fields" do
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Organization can't be blank")
        expect(page).to have_content("Volunteers needed can't be blank")
      end
    end
  end

  context "Seeing Form Errors on Organization Form" do
    Steps "Going to the events form" do
      Given "I am logged in as an organizer" do
        visit new_user_session_path
        fill_in "user[email]", with: @u.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
      end
      Then "I can go to the events index" do
        visit organizations_path
      end
      And "I can click a button to create an event" do
        click_link "New Organization"
      end
      And "If I haven't filled in the required fields then I see an error" do
        click_button "Create Organization"
      end
      And "I can see errors for the required fields" do
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
      end
    end
  end

end
