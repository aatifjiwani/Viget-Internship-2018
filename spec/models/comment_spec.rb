require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "with an Article already created" do
    let!(:article) {create(:article)}
    let!(:comment_user) {create(:user, username: 'demouser2', email: 'demouser2@viget.com')}
    
    
    it "currently has no comments on the article" do
      expect(article.comments.count).to eq(0)
    end
    
    
    let(:comment) {create(:comment, user: comment_user, commentable: article)}
    
    it "creates a comment" do
      expect(comment.commentable).to eq(article)
      expect(article.comments.first).to eq(comment)
    end
    
    it "allows nested comments" do
      nested_comment = create(:comment, user: comment_user, commentable: comment)
      expect(nested_comment.commentable).to eq(comment)
      expect(comment.comments.first).to eq(nested_comment)
    end
    
  end
end
