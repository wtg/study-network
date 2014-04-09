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

  def self.registered_courses(user)
    registrations = Registration.where(user_id: user.id)
    courses = Array.new()
    registrations.each do |reg| 
      courses.push(Course.find(reg.course_id))
    end
    return courses
  end

  def self.search(search)
    if search
      users = Array.new()
      u1 = find(:all, conditions: ["real_name LIKE ?", "%#{search}%"])
      u2 = find(:all, conditions: ["username LIKE ?", "%#{search}%"])
      users = u1 + u2
      users.uniq
    else
      find(:all)
    end
  end

end
