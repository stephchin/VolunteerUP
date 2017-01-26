require 'rails_helper'

RSpec.feature "SocialMediaLogins", type: :feature do
  context 'Using social media authentication' do
    Steps 'Logging in with social media' do
      Given 'I am on the Sign Up page' do
        visit '/users/sign_up'
      end
      Then 'I can see a Sign In With Twitter button' do
        expect(page).to have_selector(:link_or_button, 'Log in with Twitter')
      end
      And 'I can see a Sign In With Facebook button' do
        expect(page).to have_selector(:link_or_button, 'Log in with Facebook')
      end
    end
  end
end
