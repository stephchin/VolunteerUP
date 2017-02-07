require 'rails_helper'

RSpec.feature "EditProfiles", type: :feature, js: true do
  before(:each) do
    @user = User.find_by_email("a@yahoo.com")
    @pw = "123456"
  end

  context 'I can update my profile' do
    Steps 'I can go to my profile page' do
      Given 'I am logged in and on my profile page' do
        visit '/'
        click_link 'Log in'
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
        # visit user_path(@user)
      end
      Then 'I can follow a link to edit my settings' do
        within (".container") do
          click_link "My Settings"
        end
      end
      And 'I can update my name and profile picture without a password' do
        fill_in "user_name", with: "Kate"
        # page.attach_file("user_image", "spec/fixtures/sample_profilepic.png")
      end
      Then 'I can submit my updated information' do
        # page.find('#update-profile-submit').trigger("click")
        click_button("Update Profile")
      end
      And 'My profile information will successfully update' do
        expect(page).to have_current_path(user_path(@user))
        expect(page).to have_content("Kate")
        # expect(page).to have_css("img[src*='sample_profilepic.png']")
      end
      Then 'I try to change my email and password without entering my current password' do
        within(".container") do
          click_link "My Settings"
        end
        click_link "Account"
        fill_in "user[email]", with: "kate@kate.com"
        fill_in "user[password]", with: "123455"
        fill_in "user[password_confirmation]", with: "123455"
        click_button "Update Account"
      end
      And 'Profile update will return an error' do
        click_link "Account"
        expect(page).to have_content("password can't be blank")
      end
      Then 'I can successfully update my email and password when I enter my current password' do
        click_link "Account"
        fill_in "user[email]", with: "kate@kate.com"
        fill_in "user[password]", with: "123455"
        fill_in "user[password_confirmation]", with: "123455"
        fill_in "user[current_password]", with: @pw
        click_button "Update Account"
        expect(page).to have_current_path(user_path(@user))
        expect(page).to have_content("kate@kate.com")
      end

      # The following two steps are needed to reset Ally's profile/account information in the test database
      # Do not remove this portion or the tests will subsequently fail

      Then 'Reset profile for testing' do
        within(".container") do
          click_link "My Settings"
        end
        click_link "Profile"
        fill_in "user_name", with: "Ally"
        click_button "Update Profile"
      end
      Then 'Reset account for testing' do
        within(".container") do
          click_link "My Settings"
        end
        click_link "Account"
        fill_in "user[email]", with: "a@yahoo.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        fill_in "user[current_password]", with: "123455"
        click_button "Update Account"
      end
    end
  end


end
