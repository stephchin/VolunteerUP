require 'rails_helper'

RSpec.feature "TwitterLogins", type: :feature do
  context 'Using Twitter authentication' do
    Steps 'Logging in with Twitter' do
      Given 'I am on the Sign Up page' do
        visit '/users/sign_up'
      end
      Then 'I can see a Sign In With Twitter button' do
        expect(page).to have_selector(:link_or_button, 'Log in with Twitter')
      end
    end
  end
end
