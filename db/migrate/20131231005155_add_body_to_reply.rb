class AddBodyToReply < ActiveRecord::Migration
  def change
    add_column :replies, :body, :string
  end
end
