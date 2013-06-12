class User < ActiveRecord::Base
  attr_accessible :address, :city, :country, :email, :fullname, :login, :state, :zip, :password, :password_confirmation
  has_secure_password
  geocoded_by :full_address
  after_validation :geocode

  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :login, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :fullname, presence: true, length: { maximum: 50 }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def full_address
    "#{address}, #{city}, #{state}, #{zip}, #{country}"
  end

end
