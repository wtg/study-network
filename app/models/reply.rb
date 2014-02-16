class Reply < ActiveRecord::Base

  belongs_to :post
  belongs_to :user

  validates :body, :post_id, presence: true

  scope :post_replies, lambda { |post_id| joins(:user).where(users: {inactive: false}, 
                              replies: {post_id: post_id}).order('created_at DESC') }

end
