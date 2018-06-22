require 'rails_helper'

RSpec.describe Vote, type: :model do
  context 'with existing article and user' do
    let!(:user) {create(:user)}
    let!(:article) {create(:article, user: user)}
    
    it "does not have any votes yet" do
      expect(article.votes.sum(:value)).to eq(0)
    end
    
    it 'adds a +1 vote to article' do
      create(:vote, article: article, user: user)
      expect(article.votes.sum(:value)).to eq(1)
    end
    
    it 'does not add a duplicate vote' do 
      create(:vote, article: article, user: user)
      expect{create(:vote, article: article, user: user, value: -1)}.to raise_error(ActiveRecord::RecordNotUnique)
      expect(article.votes.count).to eq(1)
    end
  end
end
