class Comment < ActiveRecord::Base
  attr_accessible :content, :micropost_id, :user_id
  belongs_to :micropost

  validates :content, presence: true, length: { maximum: 140 }
  validates :micropost_id, presence: true
  validates :user_id, presence: true

  default_scope order: 'comments.created_at DESC'

  def by
  	user.fullname
  end

  def user
  	User.find_by_id(self.user_id)
  end
end
