class RemoveCrnFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :crn, :string
  end
end
