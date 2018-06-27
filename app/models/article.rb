class Article < ApplicationRecord
  
  validates :title, presence: true, length: { minimum: 5 }

  validates :body, presence: true

  has_one_attached :content_img
  
  belongs_to :user
  
  has_many :comments, as: :commentable, dependent: :destroy
  
  has_many :votes, as: :voteable, dependent: :destroy
  
  scope :article_top_10, -> { joins(:votes).group(:voteable_id).limit(10).sum(:value) }
  scope :article_top_10_year, -> { joins(:votes).where("articles.created_at >= ?", DateTime.now - 1.year).group(:voteable_id).sum(:value) }
  scope :article_top_10_month, -> { joins(:votes).where("articles.created_at >= ?", DateTime.now - 1.month).group(:voteable_id).sum(:value) }
  scope :article_top_10_day, -> { joins(:votes).where("articles.created_at >= ?", DateTime.now - 1.day).group(:voteable_id).sum(:value) }
  
  def parent_is?(user)
    if user
      user.id == self.user.id
    end
  end
  
    
  def preview_body
    "#{ActionView::Base.full_sanitizer.sanitize(self.body.strip)[0..155]}..."
  end
end
