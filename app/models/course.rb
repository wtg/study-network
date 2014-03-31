class Course < ActiveRecord::Base

  validates :title, :crn, :abrev_name, presence: true
  validates :crn, :title, uniqueness: true

  has_many :registrations, :dependent => :delete_all
  has_many :posts, :dependent => :delete_all

  scope :department_courses, lambda { |course_dept| where(abrev_name: course_dept) }

  def self.search(search)
    if search
      courses = Array.new()
      c1 = find(:all, conditions: ['title LIKE ?', "%#{search}%"])
      c2 = find(:all, conditions: ['abrev_name LIKE ?', "%#{search}%"])
      courses = c1 + c2
      courses.uniq
    else
      find(:all)
    end
  end

end
