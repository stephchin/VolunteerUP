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
    end
  end
end
