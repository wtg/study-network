class Reply < ActiveRecord::Base

  belongs_to :post

  validates :body, :post_id, presence: true

end
