require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'Going to the landing page' do
    Steps 'Go to landing page' do
      Given 'We are on the landing page' do
        visit '/'
      end
      Then 'I can see a description of the service' do
        expect(page).to have_content("VolunteerUP is")
      end
      And 'I can see the navigation bar' do
        expect(page).to have_content("About")
      end
      And 'I can click the login link' do
        click_link('Log in')
      end
      And 'I can click link and go to log in page' do
        expect(page).to have_content('Log in')
      end
    end
  end
end
