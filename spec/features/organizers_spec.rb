require 'rails_helper'

RSpec.feature "Organizers", type: :feature do
  before(:each) do
    @user = User.find_by_email("a@yahoo.com")
    @pw = "123456"
    @org_name = "Nice Guys"
    @org_desc = "We're chill"
    @org_phone = "(555)-555-5555"
    @org_email = "me@yahoo.com"
    @org_website = "www.niceguys.com"
    @org_twitter = "http://www.twitter.com/niceguys"
    @org_facebook = "http://www.facebook.com/niceguys"
    @org = Organization.find_by_name("We Help")
    @user2 = User.find_by_email("b@yahoo.com")
    @user3 = User.find_by_email("c@yahoo.com")
  end
  context "Organizer/Creator" do
    Steps "Go to organization page" do
      Given "I am on the organization page and can create a new organization" do
        visit new_user_session_path
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
        visit organizations_path
        click_link "New Organization"
        expect(page).to have_current_path(new_organization_path)
      end
      Then "I can create a new organization" do
        fill_in "organization[name]", with: @org_name
        fill_in "organization[description]", with: @org_desc
        fill_in "organization[phone]", with: @org_phone
        fill_in "organization[email]", with: @org_email
        fill_in "organization[website]", with: @org_website
        fill_in "organization[twitter]", with: @org_twitter
        fill_in "organization[facebook]", with: @org_facebook
        page.attach_file("organization_image", "spec/fixtures/default_org.png")
        click_button "Create Organization"
      end
      And "I will be redirected to my dashboard page" do
        expect(page).to have_content(@org_name)
        expect(page).to have_css("img[src*='default_org.png']")
      end
      Then "I can see 'Org Dashboard' on my nav bar" do
        visit user_path(@user.id)
        @user.user_organizations.create(organization: @org, is_creator: true)
        @user2.user_organizations.create(organization: @org, is_creator: false)
        @user3.user_organizations.create(organization: @org, is_creator: false)
        expect(page).to have_content("Org Dashboard")
      end
      Then "In the dashboard, I can see all the listed organizers" do
        @user.user_organizations.create(organization: @org, is_creator: true)
        @user2.user_organizations.create(organization: @org, is_creator: false)
        @user3.user_organizations.create(organization: @org, is_creator: false)
        click_link "Dashboard"
        expect(page).to have_current_path(dashboard_organizations_path)
        expect(page).to have_content("Creator")
        expect(page).to have_content("Organizer")
      end
    end
  end
end
