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
      Then "I can press the 'Sign up' button and go to sign up page" do
        click_link('Sign up')
        expect(page).to have_current_path(new_user_registration_path)
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
        select 'OH', from: 'user_state'
        fill_in "user[email]", with: "123@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        page.attach_file("user_image", "spec/fixtures/default_user.png")
        # select "Organizer", from: "role"
        # select @organization.name, from: "organization"
        click_button "Sign up"
        expect(page).to have_content("Welcome to VolunteerUP! You've successfully signed up.")
      end
      Then "I can see that I am logged in" do
        expect(page).to have_content("Suzan")
        expect(page).to have_content("Profile")
        expect(page).to have_content("Log out")
        expect(page).to_not have_content("Log in")
        expect(page).to_not have_content("Sign up")
      end
      And "I can see my user profile page" do
        @user = User.find_by_email("123@yahoo.com")
        visit user_path(@user.id)
        expect(page).to have_content "Suzan"
        expect(page).to have_content "123@yahoo.com"
        expect(page).to have_content "Cincinnati OH"
        expect(page).to have_css("img[src*='default_user.png']")
        expect(page).to have_content "My Organizations"
      end
      And "I can see that I am assigned a default role of volunteer" do
        expect(page).to have_content "Volunteer"
      end
    end
  end
end
