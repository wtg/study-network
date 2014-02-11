class Registration < ActiveRecord::Base
  validates :course_id, :user_id,  presence: true
  belongs_to :user
  belongs_to :course

end
