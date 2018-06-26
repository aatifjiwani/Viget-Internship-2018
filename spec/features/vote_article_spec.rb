require 'rails_helper'

RSpec.describe 'Voting on an Article', type: :feature do
  context "with an existing article" do
    let!(:user) {create(:user)}
    let!(:article) {create(:article, user: user)}
    
    it 'does not let you vote without signed in user' do
      visit root_path
      page.find(".vote-article-up-nil-#{article.id}").click
      within('.article-vote') do
        expect(find('.article-vote-count')).to have_content(0);
      end
    end
    
    context 'with a signed in user' do
      let!(:vote_user) {login_user(name: 'voteuser', email: 'voteuser@example.com')}
      
      it "let's you upvote on the article", js: true do
        visit root_path
        page.find(".vote-Article-button-up-#{article.id}").click
        within('.article-vote') do
          expect(find('.article-vote-count')).to have_content(1);
        end
      end
      
      it "does't let you add multiple votes on the article", js: true do
        visit root_path
        page.find(".vote-Article-button-up-#{article.id}").click
        page.find(".vote-Article-button-up-#{article.id}").click
        within('.article-vote') do
          expect(find('.article-vote-count')).to have_content(1);
          expect(Vote.count).to eq(1);
        end
      end
      
      it "let's you replace downvote with upvote on the article", js: true do
        visit root_path
        page.find(".vote-Article-button-up-#{article.id}").click
        page.find(".vote-Article-button-down-#{article.id}").click
        within('.article-vote') do
          expect(find('.article-vote-count')).to have_content(-1);
        end
      end
    end
  end
end