class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 6}

  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: EMAIL_REGEX

  has_one_attached :profile_img

  has_secure_password

end
