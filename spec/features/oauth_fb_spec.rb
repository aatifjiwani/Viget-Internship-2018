require 'rails_helper'

RSpec.describe 'Signing in to Facebook with OAuth', type: :feature do
  describe 'creating an account through FB', js: true do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      visit new_user_path
      find('#facebook').click
    end

    it 'creates a new user' do
      expect(User.count).to be(1)
      user = User.first
      expect(user.username).to eq("facebookuser")
      expect(user.email).to eq("facebook@example.com")
    end

    it "doesn't allow you to sign in natively" do
      click_on 'Sign Out'
      visit new_sessions_path
      fill_in 'Username:', with: 'facebookuser'
      fill_in 'Password:', with: 'fakepassword'
      within('.li-submit') do
        click_on 'Sign In'
      end
      expect(page).to have_content "facebookuser, please sign in using Facebook"
    end

    it 'allows you to sign in via Facebook' do
      visit new_sessions_path
      find('#facebook').click
      expect(page).to have_content 'Signed in!'
    end
  end
end