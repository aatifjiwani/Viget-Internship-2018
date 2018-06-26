class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  belongs_to :user
  
  scope :user_articles_voted, lambda{|user| where(user: user, voteable_type: "Article").pluck(:voteable_id) }
end
