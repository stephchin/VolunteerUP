require 'rails_helper'

RSpec.feature "EditProfilesOmniauthProviderSpecs", type: :feature do
  before(:each) do
    @user = User.find_by_email("a@yahoo.com")
    @pw = "123456"
  end

  context 'Omniauth Provider Profile' do
    Steps 'Omniauth Provider Profile' do
      Given 'I am logged in and on my profile page' do
        visit '/'
        click_link 'Log in'
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
        # visit user_path(@user)
      end
      Then 'As a facebook user, I cannot see password or email fields' do
        @user.provider = "facebook"
        @user.save
        within(".container") do
          click_link "My Settings"
        end
        click_link ("Account")
        expect(page).to have_content("Authentication Provider")
        expect(page).to_not have_content("Change Email")
        expect(page).to_not have_content("Change Password")
      end
    end
  end
end
