class AddAbrevNameToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :abrev_name, :string
  end
end
