class Course < ActiveRecord::Base
  validates :title, :crn, :abrev_name, :level, :section,  presence: true
  has_many :registrations
end
