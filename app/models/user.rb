class User < ActiveRecord::Base
  YEARS = ['Freshman', 'Sophomore', 'Junior', 'Senior', 'Graduate', 'Other']
  has_many :registrations
  has_many :courses, :through => :registrations
end
