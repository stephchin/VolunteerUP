require 'rails_helper'

RSpec.feature "Dashboards", type: :feature do
  before(:each) do
    @u1 = User.find_by_email("t@yahoo.com")
    @u2 = User.find_by_email("z@yahoo.com")
    @org = Organization.create(name: "Yes", description: "We do everything",
      phone: "555-555-5555", email: "yes@yahoo.com", website: "www.yes.com")
    @event = Event.create(name: "ABC", start_time: DateTime.now + (2.0 / 24.0),
      end_time: DateTime.now + (5.0 / 24.0), volunteers_needed: 1 )
    @event.organization = @org
    @event.save
    @event.user_events.create(user: @u2)
    @event.user_events.create(user: @u1, waitlist: 1)
    @pw = "123456"
    @u1.user_organizations.create(organization: @org, is_creator: false)
    @u2.user_organizations.create(organization: @org, is_creator: true)
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
        click_button("X", match: :first)
        expect(page).to have_content("Creator")
        expect(page).to have_selector("tr.organizer", count: 1)
      end
      Then "As an organizer, I can Edit/Delete an Organization" do
        click_link "Edit"
        expect(page).to have_current_path(edit_organization_path(@org.id))
        visit dashboard_organizations_path
        # expect(page).to have_link("Delete", "organizations/" + @org.id.to_s)
      end
      Then "I can click the link to go to that organization's page" do
        within (".tab-content") do
          click_link @org.name
        end
        expect(page).to have_current_path(organization_path(@org.id))
      end
      Then "I can click the user's name to go to their page" do
        visit dashboard_organizations_path
        within('#org-dash') do
        click_link @u2.name
        end
        expect(page).to have_current_path(user_path(@u2.id))
      end
      Then "I can click 'Volunteer List' and see all volunteers in order" do
        visit dashboard_organizations_path
        click_link("Volunteer List", match: :first)
        expect(page).to have_content(@u2.email)
        expect(page).to have_content(@u1.email)
        expect(page).to have_selector("tr.vol-row", count: 2)
        expect(page).to have_css("tr.vol-row:nth-of-type(1)", text: @u2.name)
        expect(page).to have_css("tr.vol-row:nth-of-type(2)", text: @u1.name)
      end
      Then "I can see the number of volunteers for an event" do
        expect(page).to have_css("h6", text: "0 needed / 1 total")
      end
      Then "I can remove a volunteer from an event" do
        click_button "Remove From Event"
        expect(page).to have_selector("form > input[value='Remove From Event']",
          count: 1)
      end
    end
  end
end
