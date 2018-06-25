require 'rails_helper'

RSpec.describe 'Articles', type: :feature do
  context 'with already signed in user' do    
    before do
      login_user
    end
    
    it "Lets you create an article" do
      visit new_article_path
      
      fill_in "Title:", with: "ArticleTest"
      fill_in "Content:", with: "This is content for this article"

      click_on 'Create'

      expect(page).to have_content "ArticleTest"
    end
  end

  context 'with existing articles'do
    before do
      another_user = login_user(name: 'demouser2', email: 'demouser2@example.com')
      create(:article, title: 'First Article', user: another_user)
      create(:article, title: 'Second Article', user: another_user)
      visit root_url
    end

  
    
    it "Lets you view articles on the index page" do
      expect(page).to have_content "First Article"
      expect(page).to have_content "Second Article"
    end

    it "Lets you delete an article on the index page" do
      
      first(:link, 'Delete').click

      expect(page).to_not have_content 'Second Article'
      
    end
  end
end