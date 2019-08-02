class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
        @user = current_user
    end

    def destroy
        @project = Project.find(params[:id]) 
        @project.destroy
        flash[:notice] = "Project has been deleted." 
        redirect_to user_path(current_user)
    end

    

    def show
        @project = Project.find(params[:id])
        
    end

    def create
        @project = Project.create(project_params)
        redirect_to project_path(@project)
    end

    def set_featured_project
        current_user.featured_project(params[:project_id])
        redirect_to my_projects_path
    end

    def add_collaborator
        Collaborator.find_or_create_by(project_id: params[:project_id], user_id: params[:user][:id])
        redirect_to project_path(params[:project_id])
    end

    private
    def project_params
        params.require(:project).permit(:user_id, :name, :description, skill_ids:[])
    end


end
