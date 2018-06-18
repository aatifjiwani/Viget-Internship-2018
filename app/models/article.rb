class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }

  validates :body, presence: true

  has_one_attached :content_img
  
  belongs_to :user
  
  def parent_is?(user)
    user.id == self.user.id
  end
end
