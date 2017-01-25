require 'rails_helper'

RSpec.feature "Dashboards", type: :feature do
  before(:each) do
    @u1 = User.find_by_email("t@yahoo.com")
    @u2 = User.find_by_email("k@yahoo.com")
    @org = Organization.find(@u2.user_organizations.all.find_by(is_creator: true).organization_id)
    @pw = "123456"
    @u1.user_organizations.create(organization: @org, is_creator: false)
  end
  context "Organizer Dashboard" do
    Steps "At the dashboard" do
      Given "I am logged on and on the dashboard page" do
        visit new_user_session_path
        fill_in "user[email]", with: @u2.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
        visit dashboard_organizations_path
      end
      Then "I can see that there are two organizers" do
        expect(page).to have_content("Creator")
        expect(page).to have_content("Organizer")
        expect(page).to have_selector("tr", count: 3)
      end
      Then "I can delete only the other organizer" do
        click_button "X"
        expect(page).to have_content("Creator")
        expect(page).to have_selector("tr", count: 2)
      end
    end
  end
end
