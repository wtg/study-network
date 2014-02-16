class Registration < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :course

  validates :course_id, :user_id,  presence: true

  scope :user_courses, lambda { |user| where(user_id: user.id) }

end
