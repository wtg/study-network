class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :course

  validates :title, :body, :course_id, :user_id, :username, presence: true

  has_many :replies, :dependent => :delete_all

  scope :course_posts, lambda { |course_id| joins(:user).where(users: {inactive: false}, 
                              posts: {course_id: course_id}).order('created_at DESC') }

  scope :recent_posts, all.sort_by(&:created_at).reverse

end
