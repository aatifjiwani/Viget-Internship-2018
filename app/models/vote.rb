class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  scope :user_articles_voted, -> (user) { where(user: user, voteable_type: "Article").order(updated_at: :desc) }
end
