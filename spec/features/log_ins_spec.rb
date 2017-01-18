require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  context "I can go to login page" do
    Steps "I can go to the landing page and press the 'Log in' button" do
      Given "I am on the landing page" do
        visit '/'
      end
      skip Then "I can press the 'Log in' button" do
        click_link('Log in')
        expect(page).to have_content "Log in"
      end
    end
  end
end
