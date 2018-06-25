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
    end
    
    it 'orders based on popularity', js: true do
      visit root_path
      #page.select "All-Time Top Rated", from: "#article_select"
      within "#article_select" do
        find("option[value='All-Time Top Rated']").click
      end
      binding.pry
    end
  end
end