require 'rails_helper'

RSpec.describe 'Signing in to Facebook with OAuth', type: :feature do
  describe 'creating an account through FB', js: true do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      visit new_user_path
    end
    
    it 'creates a new user' do
      find('#facebook').click
      expect(User.count).to be(1)
    end
  end
end