require 'rails_helper'

RSpec.feature "JoinOrgs", type: :feature do
  before(:each) do
    @user = User.create(name: "YungTony", email:"t_eazy@bigmoney.com", password:"password", password_confirmation: "password", city: "Cincinnasty", state: "OH" )
    @organization = Organization.new(name: "ABC", description: "ABC is a helpful org")
    @organization.save
  end
   context 'A user can have many organizations' do
     Steps 'I can click Join on an organization page' do
       Given 'I am on the specific organization page and logged in' do
         visit '/'
         click_link 'Log in'
         fill_in "user[email]", with: "t_eazy@bigmoney.com"
         fill_in "user[password]", with: "password"
         click_button "Log in"

         visit user_path(@user)
       end
       Then 'I can visit the organizations page' do
         click_link 'Organizations'
       end
       And 'I can visit the specific organization' do
         click_link 'ABC'
         expect(page).to have_content "ABC"
       end
       Then 'I can view and join the organization' do
         click_button "Join!"
       end
       And 'I can see a message saying you have joined' do
         expect(page).to have_content('Congrats, you have joined the organization')
       end
       Then 'I can see a message saying I have already joined' do
         expect(page).to have_content("You've already joined")
       end
     end

   end
end
