require 'rails_helper'

RSpec.describe Article, type: :model do
  it "has none to begin with" do
    expect(Article.count).to eq(0)
  end

  context "with two users created" do 
    let!(:user_1) {create(:user)}
    let!(:user_2) {create(:user, username: "demouser2", email: "demouser2@gmail.com")}

    let!(:article) {create(:article, user: user_1)}

    it "creates an article with proper parent" do
      expect(article.user).to eq(user_1)
      expect(article.parent_is?(user_1)).to be true
    end

    it "returns false if article is checked with wrong parent" do
      expect(article.parent_is?(user_2)).to be false
    end
    
    it "returns nil if article is checked with a nil parent" do 
      expect(article.parent_is?(nil)).to be nil
    end
  end
end