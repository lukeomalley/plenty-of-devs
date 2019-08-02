class AddIsFeaturedToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :is_featured, :boolean
  end
end
