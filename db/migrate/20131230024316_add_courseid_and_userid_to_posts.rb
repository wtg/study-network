class AddCourseidAndUseridToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :course_id, :integer
    add_column :posts, :user_id, :integer
  end
end
