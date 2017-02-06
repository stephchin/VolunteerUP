require 'rails_helper'

RSpec.feature "EditProfiles", type: :feature do
  before(:each) do
    @user = User.first
  end

  context 'I can update my profile' do
    Steps 'I can go to my profile page' do
      Given 'I am logged in and on my profile page' do
        visit '/'
        click_link 'Log in'
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        visit user_path(@user)
      end
      Then 'I can follow a link to edit my account settings' do
        click_link "Account Settings"
      end
      And 'I can update my name and profile picture without a password' do
        fill_in "user[name]", with: "Kate"
        page.attach_file("user_image", "spec/fixtures/default_user.png")
      end
      Then 'I can submit my updated information' do
        click_button "Update"
      end
      And 'My profile information will successfully update' do
        expect(page).to have_current_path(user_path(@user))
        expect(page).to have_css("img[src*='default_user.png']")
      end
      Then 'I can only update my email and password by using my current password' do
        # fill this stuff in
      end
    end
  end


end
