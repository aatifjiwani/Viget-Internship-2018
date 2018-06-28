class User < ApplicationRecord
  include VotesHelper

  attr_accessor :should_locate

  attr_accessor :bypass_creation, :oauth_creation
  
  #EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 6}

  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: URI::MailTo::EMAIL_REGEXP

  has_one_attached :profile_img

  has_secure_password validations: false
  validates_confirmation_of :password, unless: :oauth?
  validates :password, presence: true, unless: :bypass?
  
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_secure_token :password_token
  
  has_many :votes, dependent: :destroy
  
  def user_karma
    @count = 0
    self.articles.each do |article|
      @count += total_votes(article)
    end
    @count + Vote.where(user: self).count
  end
  
  def bypass?
    bypass_creation
  end
  
  def oauth?
    oauth_creation
  end
end
