class ProjectsController < ApplicationController

  def index
    @user = User.find_by_id(params[:user_id])
    if @user
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
        if params[:task_field] == "ADD TASK"
          flash[:redirect] = "ADD"
          redirect_to edit_user_project_path(@user, @project)
        else
          redirect_to user_projects_path
        end
      else
        render :new
      end
  end

  def edit
    @user = current_user
    @project = Project.find(params[:id])
    if flash[:redirect] == "ADD"
      @project.tasks.build
    end
  end

  def update
    @project = Project.find(params[:id])
    @user = current_user
    if @project.update(project_params)
      if params[:task_field] == "ADD TASK"
        flash[:redirect] = "ADD"
        redirect_to edit_user_project_path(@user, @project)
      else
        redirect_to user_projects_path
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


  def add_task
    @project = Project.find(params[:id])
    @user = current_user
    @project.tasks.build
    render :new
  end

  private

  def project_params
    params.require(:project).permit(:name, :due_date, user_ids:[], tasks_attributes: [:user_id, :project_id, :name, :done])
  end

end
