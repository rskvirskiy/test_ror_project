class Comment < ActiveRecord::Base
  attr_accessible :content, :micropost_id, :by
  belongs_to :micropost

  validates :content, presence: true, length: { maximum: 140 }
  validates :micropost_id, presence: true
  validates :by, presence: true

  default_scope order: 'comments.created_at DESC'
end
