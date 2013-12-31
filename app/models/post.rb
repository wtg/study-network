class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :course

  has_many :replies

  validates :title, :body, :course_id, presence: true

end
