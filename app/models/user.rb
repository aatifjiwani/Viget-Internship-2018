class User < ApplicationRecord
  attr_accessor :password
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: true, length: {minimum: 6}

  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, confirmation: true 
  
  before_save :encrypt_password
  
  has_one_attached :profile_img

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
end
