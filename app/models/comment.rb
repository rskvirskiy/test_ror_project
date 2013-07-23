class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :micropost

  validates :content, presence: true, length: { maximum: 140 }
  validates :micropost_id, presence: true

  default_scope order: 'comments.created_at DESC'
end
