require 'rails_helper'

RSpec.describe 'User Article Interaction', type: :feature do
  describe 'Creating an article that links to your account' do
    context 'With valid credentials' do

      let!(:user) { login_user(name: 'demouser', email: 'demouser@example.com') }

      it 'logs the user in' do
        expect(page).to have_content "Sign Out"
        expect(page).to have_content "Create Post"
      end
      
      before do
        create(:article, title: 'Linking article', user: user)
      end

      it 'creates an article linked to your username' do
        visit root_url
        expect(page).to have_content "Linking article"
        expect(page).to have_content "by #{user.username}"
      end
      
      it 'allows you to delete your own article' do
        visit root_url
        expect(page).to have_content 'Delete'
        click_on 'Delete'
        expect(page).to_not have_content 'Linking article'
      end
    end  
  end
end