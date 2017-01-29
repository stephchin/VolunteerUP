require 'rails_helper'

RSpec.feature "CreateOrgs", type: :feature do
  before(:each) do
    @u1 = User.first
    @pw = "123456"
    @org_name = "For the Horde"
    @org_desc = "We fight the filthy Alliance scum. Lok'tar Ogar!"
    @org_phone = "619-555-5555"
    @org_email = "fth@yahoo.com"
    @org_website = "www.fth.com"
    @org_desc_new = "Just a prank, bro"
  end

  context "Create Organization" do
    Steps "Go to organization page" do
      Given "I am a logged in user" do
        visit new_user_session_path
        fill_in "user[email]", with: @u1.email
        fill_in "user[password]", with: @pw
        click_button "Log in"
      end
      Then "I can create an organization" do
        visit organizations_path
        click_link "New Organization"
        expect(page).to have_current_path(new_organization_path)
        fill_in "organization[name]", with: @org_name
        fill_in "organization[description]", with: @org_desc
        fill_in "organization[phone]", with: @org_phone
        fill_in "organization[email]", with: @org_email
        fill_in "organization[website]", with: @org_website
        click_button "Create Organization"
        @org = Organization.find_by_name(@org_name)
        expect(page).to have_content(@u1.name)
      end
      Then "I can edit the organization" do
        click_link "Edit"
        expect(page).to have_current_path(edit_organization_path(@org.id))
        fill_in "organization[description]", with: @org_desc_new
        click_button "Update Organization"
        expect(page).to have_content("#{@org.name} was successfully updated!")
      end

    end
  end
end
