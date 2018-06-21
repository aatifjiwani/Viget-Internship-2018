class Comment < ApplicationRecord
  validates :body, presence: true

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  
  belongs_to :user
  
  def parent_post
    return @article if defined?(@article)
    @article = commentable.is_a?(Article) ? commentable : commentable.parent_post
  end
end
