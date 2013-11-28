class AddInactiveToUser < ActiveRecord::Migration
  def change
    add_column :users, :inactive, :boolean
  end
end
