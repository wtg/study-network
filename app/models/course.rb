class Course < ActiveRecord::Base

  validates :title, :crn, :abrev_name, :level, presence: true
  validates :crn, :title, uniqueness: true

  has_many :registrations, :dependent => :delete_all
  has_many :posts, :dependent => :delete_all

end
