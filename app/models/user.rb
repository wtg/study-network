class User < ActiveRecord::Base

  YEARS = ['Freshman', 'Sophomore', 'Junior', 'Senior', 'Graduate', 'Other']
  
  has_many :registrations
  has_many :courses, :through => :registrations
  has_many :posts, :dependent => :delete_all

  validates :username, :real_name, :email, presence: true
  validates :username, :real_name, :email, uniqueness: { case_sensitive: false }
  validates :inactive, inclusion: { in: [true, false] }

  scope :active, where(inactive: false)
  scope :course_registrations, 
        lambda { | course_id | User.joins(:registrations).where(
        users: {inactive: false}, registrations: {course_id: course_id}).shuffle! }

end
