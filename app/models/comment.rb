class Comment < ApplicationRecord
  validates :body, presence: true
  validates :author, presence: true

  has_many :comments, as: :commentable
  belongs_to :commentable, polymorphic: true
  
  def parent_post
    return @article if defined?(@article)
    @article = commentable.is_a?(Article) ? commentable : commentable.parent_post
  end
end
