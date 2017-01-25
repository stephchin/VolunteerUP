require 'rails_helper'

RSpec.feature "Dashboards", type: :feature do
  before(:each) do
    @u1 = User.find_by_email("t@yahoo.com")
    @u2 = User.find_by_email("k@yahoo.com")
    @org = Organization.find(@u2.user_organizations.all.find_by(is_creator: true).organization_id)
    @event = Event.first
    @event.user_events.create(user: @u2)
    @event.user_events.create(user: @u1)
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
        expect(page).to have_selector("tr.organizer", count: 2)
      end
      Then "As a creator, I can delete the organizer" do
        click_button "X"
        expect(page).to have_content("Creator")
        expect(page).to have_selector("tr.organizer", count: 1)
      end
      Then "As an organizer, I can Edit/Delete an Organization" do
        click_link "Edit"
        expect(page).to have_current_path(edit_organization_path(@org.id))
        visit dashboard_organizations_path
        expect(page).to have_link("Delete", "/organizations/" + @org.id.to_s)
      end
      Then "I can click the link to go to that organization's page" do
        click_link @org.name
        expect(page).to have_current_path(organization_path(@org.id))
      end
      Then "I can click the user's name to go to their page" do
        visit dashboard_organizations_path
        click_link @u2.name
        expect(page).to have_current_path(user_path(@u2.id))
      end
      Then "I can click 'Volunteer List' and see all volunteers" do
        visit dashboard_organizations_path
        click_link("Volunteer List", match: :first)
        expect(page).to have_content(@u2.email)
        expect(page).to have_content(@u1.email)
      end
    end
  end
end
