require 'rails_helper'

RSpec.describe 'Filtering for an article', type: :feature do
  context 'with existing articles, users, and votes' do
    let!(:creator) {create(:user, username: "creator", email: "creator@example.com")}
    
    before do
      count = 0
      (1..10).each do |n|
        article = create(:article, title: "Demo Article #{n}", user: creator)
        (11 - n).times do
          user = create(:user, username: "demouser#{count}", email: "demouser#{count}@example.com")
          count+=1
          create(:vote, voteable: article, user: user)
        end
      end
      
      visit root_path
    end
    
    it 'orders by most recent by default' do
      expect(find("#article-content-1")).to have_content "Demo Article 10"
      expect(find("#article-content-10")).to have_content "Demo Article 1"
    end
    
    it 'orders based on popularity', js: true do
      #page.select "All-Time Top Rated", from: "#article_select"
      within "#article_select" do
        find("option[value='All-Time Top Rated']").click
      end
      
      expect(find("#article-content-1")).to have_content "Demo Article 1"
      expect(find("#article-content-10")).to have_content "Demo Article 10"
    end
    
    it 'orders based on time again', js: true do
      within "#article_select" do
        find("option[value='Most Recent']").click
      end
      
      expect(find("#article-content-1")).to have_content "Demo Article 10"
      expect(find("#article-content-10")).to have_content "Demo Article 1"
    end
  end
end