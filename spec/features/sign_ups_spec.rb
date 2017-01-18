require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  context "I can go to sign up page" do
    Steps "I can go to the landing page and press the 'Sign-up' button" do
      Given "I am on the landing page" do
        visit '/'
      end
      Then "I can press the 'Sign-up' button" do
        click_link('Sign-up')
        expect(page).to have_content "Sign up"
      end
    end
  end
end
