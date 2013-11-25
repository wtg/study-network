class RemoveDaysFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :days, :string
  end
end
