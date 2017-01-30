require 'rails_helper'

RSpec.feature "HideButtons", type: :feature do
  before(:each) do
    @org = Organization.create(name: "Pawnee Parks & Recs",
      description: "We have a park")
    @event = Event.new(name: "Save Gary", start_time:"2017-02-02 01:01:01",
      end_time:"2017-02-02 02:01:01", volunteers_needed: 200, organization: @org)
    @event.save
  end
  context "Logged out user cannot see 'Edit' and 'Create buttons'" do
    Steps "Go to the events page" do
      Given "I am on the events page" do
        visit '/events'
        fill_in "filterrific_search_query", with: @event.name
        click_button "Search"
        expect(page).to have_content(@org.name)
      end
      Then "I cannot see the 'Edit', 'Destroy', or 'New Event' button" do
        expect(page).to_not have_content("Edit")
        expect(page).to_not have_content("Destroy")
        expect(page).to_not have_content("New Event")
      end
      Then "I cannot see the 'Edit', 'Destroy', or 'New Organization' button" do
        visit '/organizations'
        expect(page).to_not have_content("Edit")
        expect(page).to_not have_content("Destroy")
        expect(page).to_not have_content("New Organization")
      end
      Then "I cannot see the 'Edit' button on each individual organization page" do
        visit organization_path(@org.id)
        expect(page).to_not have_content("Edit")
      end
    end
  end
end
