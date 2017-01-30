require 'rails_helper'

RSpec.feature "Waitlists", type: :feature do
  before(:each) do
    @org = Organization.find_by_name("We Help")
    @event = Event.create(name: "Clothes drives", start_time:"2017-02-02 01:01:01", end_time:"2017-02-02 02:01:01", volunteers_needed: 2 )
    @event.organization = @org
    @event.save
    @user = User.find_by_email("a@yahoo.com")
    @user.add_role :volunteer
    @u2 = User.find_by_email("b@yahoo.com")
    @u2.add_role :volunteer
    @u3 = User.find_by_email("c@yahoo.com")
    @u3.add_role :volunteer
    @event.users << @u2 << @u3
    @event.save
  end

  context 'Waitlist' do
    Steps 'Adding to the waitlist' do
      Given 'I am on the events page and logged in' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
        visit '/events'
      end
      Then 'I can click the event name' do
        fill_in "filterrific_search_query", with: @event.name
        click_button "Search"
        click_link (@event.name)
      end
      Then 'I can see that the event is full' do
        expect(page).to have_content "0 Volunteers Needed"
      end
      And 'I can click the waitlist button' do
        click_button('Add to waitlist!')
      end
      Then 'I can see a message that Ive been added to the waitlist' do
        expect(page).to have_content "You're on the waitlist!"
      end
      And 'I can see the event in my upcoming event' do
        visit user_path(@user)
        expect(page).to have_content "Your Upcoming Events"
        expect(page).to have_content "#{@event.name}"
        expect(page).to have_content "Remove From Waitlist"
      end
      And 'If another user logs in and cancels' do
        click_link "Log out"
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: @u2.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        click_link "Cancel Your RSVP"
        click_link "Log out"
      end
      And 'I log back in' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
        visit '/events'
      end
      Then 'I can see that I am moved off the waitlist automatically' do
        fill_in "filterrific_search_query", with: @event.name
        click_button "Search"
        click_link (@event.name)
        expect(page).to have_content("You're signed up!")
      end
    end
    Steps 'Cancelling from the waitlist' do
      Given 'I am on the events page and logged in' do
        visit '/'
        click_link "Log in"
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
        visit '/events'
      end
      Then 'I can click the event name and see the event is full' do
        fill_in "filterrific_search_query", with: @event.name
        click_button "Search"
        click_link (@event.name)
        expect(page).to have_content "0 Volunteers Needed"
      end
      And 'I can click the waitlist button' do
        click_button('Add to waitlist!')
      end
      Then 'I can see a message that Ive been added to the waitlist' do
        expect(page).to have_content "You're on the waitlist!"
      end
      Then 'I can go to the event in my upcoming event' do
        visit user_path(@user)
        expect(page).to have_content "Your Upcoming Events"
        expect(page).to have_content "#{@event.name}"
        expect(page).to have_content "Remove From Waitlist"
      end
      And 'I can remove myself from the waitlist' do
        click_link("Remove From Waitlist")
      end
      Then 'That event is no longer in my upcoming events' do
        within('#user-events-table') do
          expect(page).not_to have_content "#{@event.name}"
          expect(page).not_to have_content "Remove From Waitlist"
        end
      end
    end
  end

end
