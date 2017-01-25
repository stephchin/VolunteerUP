require 'rails_helper'

RSpec.feature "TweetButtons", type: :feature do
  before(:each) do
    @organization = Organization.find_by_name("We Help")
    @event = Event.create(name: "ABC", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 1 )
    @event.organization = @organization
    @event.save
    @user = User.find_by_email("a@yahoo.com")
    @user.add_role :volunteer
  end

  context 'I can tweet an event' do
    Steps 'I can tween an event' do
      Given 'I am logged in and on an event page' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
        visit event_path(@event)
      end
      Then 'I can see a tweet button' do
        expect(page).to have_xpath "//a[contains(@href,'twitter')]"
      end
      Then 'I can share a facebook event' do
        expect(page).to have_xpath "//a[contains(@href,'facebook')]"
      end
    end
  end

end
