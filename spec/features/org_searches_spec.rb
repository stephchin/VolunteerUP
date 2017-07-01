require 'rails_helper'

RSpec.feature "OrgSearches", type: :feature do
  before(:each) do
    @org = Organization.first
  end

  context "Search for organizations" do
    Steps "Input event search" do
      Given "I am on the organization index page" do
        visit organizations_path
      end
      When "I enter an organization's name" do
        fill_in "filterrific_search_query", with: @org.name
        click_button "Search"
      end
      Then "I should see only that organiation" do
        expect(page).to have_selector(".org-tbody tr", count: 1)
      end
    end
  end
end
