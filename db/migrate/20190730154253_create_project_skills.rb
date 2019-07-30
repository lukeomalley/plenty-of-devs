class CreateProjectSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :project_skills do |t|
      t.integer :project_id
      t.integer :skill_id
    end
  end
end
