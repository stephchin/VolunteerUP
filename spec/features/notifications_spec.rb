require 'rails_helper'

RSpec.feature "Notifications", type: :feature do
  before(:each) do
    @u = User.first
    @e = Event.first
    Notification.create(event: "#{@e.name} has been updated!", user_id: @u.id)
  end

  context "Delete Notifications" do
    Steps "Delete notification" do
      Given "I am logged on" do
        visit new_user_session_path
        fill_in "user[email]", with: @u.email
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then "I can see an event has been updated" do
        click_link("open_notification")
        expect(page).to have_content "#{@e.name} has been updated!"
      end
      Then "I can click a button to delete the notification" do
        within (".delete-notification") do
          find(".glyphicon").click
        end
      end
    end
  end
end
