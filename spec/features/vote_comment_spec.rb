require 'rails_helper'

RSpec.describe 'Voting on a Comment', type: :feature do
  context "with an article with existing comemnts" do
    let!(:user) {create(:user)}
    let!(:article) {create(:article, user: user)}
    let!(:comment) {create(:comment, commentable: article, user: user)}

    before do
      visit article_path(article)
    end

    it 'does not let you vote without signed in user' do
      page.find("#vote-comment-up-nil-#{comment.id}").click
      within('.comment-vote') do
        expect(find('.comment-vote-count')).to have_content(0);
      end
    end

    context 'with a signed in user' do
      let!(:vote_user) {login_user(name: 'voteuser', email: 'voteuser@viget.com')}

      before do
        visit article_path(article)
      end
      
      it "let's you upvote on the comment", js: true do
        page.find("#vote-Comment-button-up-#{comment.id}").click
        within('.comment-vote') do
          expect(find('.comment-vote-count')).to have_content(1);
        end
      end

      it "does't let you add multiple votes on the comment", js: true do
        page.find("#vote-Comment-button-up-#{comment.id}").click
        page.find("#vote-Comment-button-up-#{comment.id}").click
        within('.comment-vote') do
          expect(find('.comment-vote-count')).to have_content(1);
        end
      end

      it "let's you replace downvote with upvote on the comment", js: true do
        page.find("#vote-Comment-button-up-#{comment.id}").click
        page.find("#vote-Comment-button-down-#{comment.id}").click
        within('.comment-vote') do
          expect(find('.comment-vote-count')).to have_content(-1);
        end
      end
    end
  end
end