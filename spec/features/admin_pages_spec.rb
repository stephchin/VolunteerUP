require 'rails_helper'

RSpec.feature "AdminPages", type: :feature do
  before(:each) do
    @u1 = User.find_by_email("t@yahoo.com")
    @u2 = User.find_by_email("z@yahoo.com")
    @u1.add_role :admin
    @u1.save
    @pw = "123456"
  end
  context "Going to the Admin Console" do
    Steps "Going to the Admin Console" do
      Given "I am logged in as an admin" do
        visit new_user_session_path
        fill_in "user[email]", with: @u1.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
      end
      Then "I can see the Admin Console link in my navbar" do
        expect(page).to have_content("Admin Console")
      end
      And "I can go to the admin Console and see all users" do
        visit admin_path
        expect(page).to have_content("All Users")
      end
      And "As an admin, I can delegate other admins" do
        expect(find('tr', text: @u2.name)).to_not have_content("Admin")
        within find('tr', text: @u2.name) do
          click_button("Make Admin")
        end
      end
      Then "Then I can see that the user has the admin role" do
        expect(find('tr', text: @u2.name)).to have_content("Admin")
      end
    end
  end
end
