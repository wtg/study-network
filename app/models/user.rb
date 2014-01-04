class User < ActiveRecord::Base
  YEARS = ['Freshman', 'Sophomore', 'Junior', 'Senior', 'Graduate', 'Other']
  has_many :registrations
  has_many :courses, :through => :registrations
  has_many :posts, :dependent => :delete_all

  validates :username, :real_name, :is_admin, :inactive, presence: true

end
