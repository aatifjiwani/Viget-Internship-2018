class Article < ApplicationRecord
	validates :title, presence: true,
									length: { minimum: 5 }

	has_one_attached :content_img
end
