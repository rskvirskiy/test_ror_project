class User < ActiveRecord::Base
  attr_accessible :address, :birthday, :city, :country, :email, :fullname, :login, :state, :zip

  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates: :email, presence: trueformat: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates: :login, presence: true, length: { maximum: 30 }, uniqueness: true
  validates: :fullname, presence: true, length: { maximum: 50 }

  before_save { |user| user.email = email.downcase }
end
