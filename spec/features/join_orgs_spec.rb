require 'rails_helper'

RSpec.feature "JoinOrgs", type: :feature do
  before(:each) do
    @user = User.create(name: "YungTony", email:"t_eazy@bigmoney.com", password:"password", password_confirmation: "password", city: "Cincinnasty", state: "OH" )
    # @organization = Organization.new(name: "ABC", description: "ABC is a helpful org", twitter: "http://twitter.com/org", facebook: "http://www.facebook.com/org")
    # @organization.save
    @org = Organization.first
  end
   context 'A user can have many organizations' do
     Steps 'I can click Join on an organization page' do
       Given 'I am on the specific organization page and logged in' do
         visit '/'
         click_link 'Log in'
         fill_in "user[email]", with: "t_eazy@bigmoney.com"
         fill_in "user[password]", with: "password"
         click_button "Log in"
         expect(page).to have_current_path(user_path(@user.id))
       end
       Then 'I can visit the organizations page' do
         click_link 'Organizations'
       end
       And 'I can visit the specific organization' do
         click_link @org.name
         expect(page).to have_content @org.name
       end
       Then 'I can see a calendar of events the organization is hosting' do
         page.has_selector?('orgcalendar', :text => 'Month', :visible => true)
       end
       Then 'I can view and join the organization' do
         click_button "Join!"
       end
       And 'I can see a message saying you have joined' do
         expect(page).to have_content("Congrats, you are now an organizer for #{@org.name}")
       end
       Then 'I can see a message saying I have already joined' do
         expect(page).to have_content("You've already joined")
       end
     end

   end
end
