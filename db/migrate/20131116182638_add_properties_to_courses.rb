class AddPropertiesToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :crn_course_sec, :string
    add_column :courses, :type, :string
    add_column :courses, :days, :string
    add_column :courses, :start_time, :string
    add_column :courses, :end_time, :string
    add_column :courses, :instructor, :string
  end
end
