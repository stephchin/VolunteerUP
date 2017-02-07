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
        page.attach_file("user_image", "spec/fixtures/sample_profilepic.png")
      end
      Then 'I can submit my updated information' do
        click_button "Update"
      end
      And 'My profile information will successfully update' do
        expect(page).to have_current_path(user_path(@user))
        expect(page).to have_css("img[src*='sample_profilepic.png']")
      end
      Then 'I try to change my email and password without entering my current password' do
        click_link "Account Settings"
        fill_in "user[email]", with: "kate@kate.com"
        fill_in "user[password]", with: "123455"
        fill_in "user[password_confirmation]", with: "123455"
        click_button "Update"
      end
      And 'Profile update will return an error' do
        expect(page).to have_content("password can't be blank")
      end
      Then 'I can successfully update my email and password when I enter my current password' do
        fill_in "user[current_password]", with: "123456"
        click_button "Update"
        expect(page).to have_current_path(user_path(@user))
        expect(page).to have_content("kate@kate.com")
      end
      And 'I cannot see password or email fields on my update page as a facebook user' do
        @user.provider = "facebook"
        @user.save
        click_link "Account Settings"
        expect(page).to_not have_field("user[email]")
        expect(page).to_not have_field("user[password]")
        expect(page).to_not have_field("user[current_password]")
      end
    end
  end


end
