class AddCrnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :crn, :string
  end
end
