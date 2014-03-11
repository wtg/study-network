class Course < ActiveRecord::Base

  validates :title, :crn, :abrev_name, :level, presence: true
  validates :crn, :title, uniqueness: true

  has_many :registrations, :dependent => :delete_all
  has_many :posts, :dependent => :delete_all

  scope :department_courses, lambda { |course_dept| where(abrev_name: course_dept) }

  def self.search(search)
    if search
      find(:all, conditions: ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
