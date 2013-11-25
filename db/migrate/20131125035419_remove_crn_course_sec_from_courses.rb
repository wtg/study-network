class RemoveCrnCourseSecFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :crn_course_sec, :string
  end
end
