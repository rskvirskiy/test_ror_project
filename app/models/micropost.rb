class Micropost < ActiveRecord::Base
  attr_accessible :content, :pic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, default_url: "empty"

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'


  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

end
