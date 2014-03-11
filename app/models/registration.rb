class Registration < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :course

  validates :course_id, :user_id,  presence: true
  validates_uniqueness_of :user_id, scope: [:course_id]

  scope :user_courses, lambda { |user| where(user_id: user.id) }

end
