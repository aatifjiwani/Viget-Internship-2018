class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  belongs_to :user
  
  scope :article_top_10, -> { where(voteable_type: "Article").group(:voteable_id).limit(10).sum(:value) }
  scope :article_top_10_year, -> { where("voteable_type = 'Article' AND created_at >= ?", DateTime.now - 1.year).group(:voteable_id).sum(:value) }
  scope :article_top_10_month, -> { where("voteable_type = 'Article' AND created_at >= ?", DateTime.now - 1.month).group(:voteable_id).sum(:value) }
  scope :article_top_10_day, -> { where("voteable_type = 'Article' AND created_at >= ?", DateTime.now - 1.day).group(:voteable_id).sum(:value) }
  
  scope :user_articles_voted, -> (user) { where(user: user, voteable_type: "Article").order(updated_at: :desc) }
  
  def query_sorted_hash(hash)
    hash.sort_by {|k,v| -v}
  end
end
