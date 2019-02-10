class ProjectsController < ApplicationController
  before_action :authentication_required

  def index
    @user = User.find_by_id(params[:user_id])
    if @user
      @your = "Your"
      @projects = @user.projects
    else
      @projects = Project.all
    end
    @user = current_user
  end

  def overdue
    @projects = Project.overdue
    @user = current_user
  end
  
  def new
    @project = Project.new
    @user = current_user
    @project.tasks.build
  end

  def create
    @user = current_user
    @project = Project.new(project_params)
      if @project.save
        if (params[:commit]) == "Save"
          redirect_to user_projects_path
        elsif (params[:commit]) == "Add Task"
          flash[:add] = "ADD"
          redirect_to edit_user_project_path(@user, @project)
        end
      else
        render :new
      end
  end

  def edit
    @user = current_user
    @project = Project.find(params[:id])
    if flash[:add] == "ADD"
      @project.tasks.build
    end
  end

  def update
    @project = Project.find(params[:id])
    @user = current_user
    if @project.update(project_params)
        if (params[:commit]) == "Save"
          redirect_to user_projects_path
        elsif (params[:commit]) == "Add Task"
          flash[:add] = "ADD"
          redirect_to edit_user_project_path(@user, @project)
        end
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to user_projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :due_date, tasks_attributes: [:user_id, :project_id, :name, :done, :id])
  end

end
