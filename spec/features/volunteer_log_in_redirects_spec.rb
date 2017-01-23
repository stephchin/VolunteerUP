require 'rails_helper'

RSpec.feature "VolunteerLogInRedirects", type: :feature do
  before(:each) do
    @organization = Organization.new(name: "ABC", description: "ABC is a helpful org")
    @organization.save
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 100 )
    @event.organization = @organization
    @event.save
    @user = User.create(name: "Michael", city: "San Diego", state: "CA", email: "1@yahoo.com", password: "123456")
  end
  
  context "Logged out user cannot volunteer and is redirected to log in area" do
    # Steps "Go to root page" do
    #   Given "I can go the Events page and go to the specific event" do
    #     visit '/'
    #     click_link 'Events'
    #     click_link 'ABC'
    #     expect(page).to have_content("Spots Remaining: 100 out of 100")
    #   end
    #   Then "I can click the 'Volunteer!' button and get redirected to log in page" do
    #     click_button 'Volunteer!'
    #     expect(page).to have_content("Log in")
    #     expect(page).to have_content("Please log in to volunteer")
    #   end
    # end
  end
end
