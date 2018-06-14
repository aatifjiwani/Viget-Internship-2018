require 'rails_helper'

RSpec.describe 'User Article Interaction', type: :feature do
  describe 'Creating an article that links to your account' do
    context 'With valid credentials' do
      let! :credentials do
        {username: 'demouser', email: 'demouser@viget.com'}
      end
      
      let! :user do 
        create(:user, credentials)
      end
      
      before do 
        visit new_sessions_path
        fill_in "Username:", with: user.username
        fill_in "Password:", with: user.password
        click_button 'Sign In'
      end
      
      it 'logs the user in' do
        expect(page).to have_content "Sign Out"
        expect(page).to have_content "Create Post"
      end
    end
  end
end