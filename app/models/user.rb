class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

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

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def full_address
    "#{address}, #{city}, #{state}, #{zip}, #{country}"
  end

end
