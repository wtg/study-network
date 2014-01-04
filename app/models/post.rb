class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :course

  has_many :replies, :dependent => :delete_all

  validates :title, :body, :course_id, :user_id, :username, presence: true

end
