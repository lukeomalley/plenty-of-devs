class AddUserIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :user_id, :integer
    add_index :projects, :user_id
  end
end
