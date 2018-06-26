require 'rails_helper'

RSpec.describe "Viewing a User's profile", type: :feature do
  context 'with existing users, articles, and votes' do
    let!(:test_user) { login_user }
    let!(:article) { create(:article, user: test_user) }
    let!(:vote_user) { create(:user, username: "voteuser", email: "voteuser@example.com") }
    
    
    before do
      create(:vote, voteable: article, user: vote_user)
      visit user_path(test_user)
    end
    
    it "displays the current Haxxor Karma" do
      expect(find('.user-karma')).to have_content(1)
    end
    
    it "displays current articles and voted articles", js: true do
      expect(page).to have_content "Demo Article"
      find('#button-vote').click
      expect(page).to have_content "Nothing found"
    end
    
    describe "voting on article changes articles in profile categories", js: true do
      before do
        page.find(".vote-Article-button-up-#{article.id}").click
        visit user_path(test_user)
      end
      
      it 'updates your Haxxor Karma' do
        expect(find('.user-karma')).to have_content(3)
      end
      
      it "updates 'Your Votes' category" do
        find('#button-vote').click
        expect(page).to have_content "Demo Article"
      end
    end
    
  end
end