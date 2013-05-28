class User < ActiveRecord::Base
  attr_accessible :address, :birthday, :city, :country, :email, :fullname, :login, :state, :zip, :password, :password_confirmation
  has_secure_password

  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :login, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :fullname, presence: true, length: { maximum: 50 }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
end
