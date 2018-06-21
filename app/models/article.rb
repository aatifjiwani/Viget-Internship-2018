class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }

  validates :body, presence: true

  has_one_attached :content_img
  
  belongs_to :user
  
  has_many :comments, as: :commentable, dependent: :destroy
  
  def parent_is?(user)
    if user
      user.id == self.user.id
    end
  end
end
