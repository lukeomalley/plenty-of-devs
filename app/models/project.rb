class Project < ApplicationRecord
    belongs_to :user
    has_many :project_skills
    has_many :skills, through: :project_skills
    accepts_nested_attributes_for :project_skills

   


end
