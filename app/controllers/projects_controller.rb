class ProjectsController < ApplicationController

    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
        @user = current_user
    end

    def show
        @project = Project.find(params[:id])
        
    end

    def create
        @project = Project.create(project_params)
        redirect_to project_path(@project)
    end

    def my_projects
    end

    private
    def project_params
        params.require(:project).permit(:user_id, :name, :description, skill_ids:[])
    end


end
