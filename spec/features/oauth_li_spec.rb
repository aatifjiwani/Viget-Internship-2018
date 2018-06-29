require 'rails_helper'

RSpec.describe 'Signing in to LinkedIn with OAuth', type: :feature do
  describe 'creating an account through LinkedIn', js: true do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:linkedin]
      visit new_user_path
      find('#linkedin').click
    end

    it 'creates a new user' do
      expect(User.count).to be(1)
      user = User.first
      expect(user.username).to eq("linkedinuser")
      expect(user.email).to eq("linkedin@example.com")
      expect(user.location).to eq({
        "country_name"=>"USA", 
        "city"=>"California", 
        "latitude"=>37.8271784, 
        "longitude"=>-122.2913078
        })
    end

    it "doesn't allow you to sign in natively" do
      click_on 'Sign Out'
      visit new_sessions_path
      fill_in 'Username:', with: 'linkedinuser'
      fill_in 'Password:', with: 'fakepassword'
      within('.li-submit') do
        click_on 'Sign In'
      end
      expect(page).to have_content "linkedinuser, please sign in using Linkedin"
    end

    it 'allows you to sign in via Linkedin' do
      visit new_sessions_path
      find('#linkedin').click
      expect(page).to have_content 'Signed in!'
    end
  end
  
  describe 'creating user through LI with same existing native user does not work', js: true do
    before do
      create(:user, username: 'linkedinuser', email: 'linkedin@example.com')
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:linkedin]
      visit new_sessions_path
      
    end
    
    it 'prompts you to sign in natively through the app' do
      find('#linkedin').click
      expect(page).to have_content "User already exists. Please sign in natively."
    end
  end
end