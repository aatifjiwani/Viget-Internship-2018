require 'rails_helper'

RSpec.describe 'Getting the current location via IP address', type: :feature do
  describe "getting the location when signing up", :vcr do
    before do
      visit new_user_path
      fill_in 'Username:', with: 'locationuser'
      fill_in 'Email:', with: 'locationuser@example.com'
      fill_in 'Password:', with: 'secret'
      fill_in 'Confirm Password:', with: 'secret'
      page.check 'Add Current Location to Profile'
      click_on 'Sign Up'
      visit user_path(User.first)
    end
    
    it 'saves the location of the user' do
      expect(User.first.location.class).to be(Hash)
      expect(page).to have_content("Huntington Beach, United States")
    end
  end
  
  describe "getting the location when posting an article", :vcr do
    before do
      login_user
      visit new_article_path
      fill_in "Title:", with: "ArticleTest"
      fill_in "Content:", with: "This is content for this article" 
      page.check 'Add Current Location to Article'
      click_on 'Create'
      visit article_path(Article.first)
    end
    
    it 'saves the location of the user' do
      expect(Article.first.location.class).to be(Hash)
      expect(page).to have_content("Huntington Beach, United States")
    end
  end
end
