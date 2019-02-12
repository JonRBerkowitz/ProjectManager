class ProjectsController < ApplicationController
  before_action :authentication_required

  def index
    @user = User.find_by_id(params[:user_id])
    if @user && @user.id == current_user.id
      @your = "Your"
      @projects = @user.projects
      flash[:edit_task] = "USER"
    else
      @projects = Project.all
      flash[:edit_task] = "ALL"
    end
    @user = current_user
  end

  def overdue
    @projects = Project.overdue
  end
  
  def finished
    @projects = Project.finished
  end


  def new
    @project = Project.new
    @project.tasks.build(user_id: params[:user_id])
  end

  def create
    @project = Project.new(project_params)
      if @project.save
        if (params[:commit]) == "Save"
          redirect_to user_projects_path
        elsif (params[:commit]) == "Add Task"
          flash[:add] = "ADD"
          redirect_to edit_user_project_path(current_user, @project)
        end
      else
        render :new
      end
  end

  def edit
    @project = Project.find(params[:id])
    if flash[:add] == "ADD"
      @project.tasks.build(user_id: params[:user_id])
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
        if (params[:commit]) == "Save"
          redirect_to user_projects_path
        elsif (params[:commit]) == "Add Task"
          flash[:add] = "ADD"
          redirect_to edit_user_project_path(current_user, @project)
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

  def correct_user?
    unless current_user == params[:user_id]
      redirect_to user_projects_path(current_user)
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :due_date, tasks_attributes: [:user_id, :project_id, :name, :done, :id])
  end

end
