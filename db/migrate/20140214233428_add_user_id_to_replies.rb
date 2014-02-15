class AddUserIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :user_id, :string
  end
end
