class ProjectsController < ApplicationController
  before_action :authentication_required

  def index
    @user = current_user
    @users = User.all
    @projects = Project.all.uniq
    respond_to do |format|
      format.html
      format.json {render json: @projects, include: ['tasks', 'tasks.user']}
    end
  end

  def overdue
    @projects = Project.overdue
  end
  
  def finished
    @projects = Project.finished
  end


  def new
    @project = Project.new
    build_task
  end

  def create
    project = Project.create(project_params)
    render json: project, status: 201
  end

  def edit
    @project = Project.find(params[:id])
    if flash[:add] == "ADD"
    build_task
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
  end

  def correct_user?
    unless current_user == params[:user_id]
      redirect_to user_projects_path(current_user)
    end
  end

  def build_task
    if User.find_by_id(params[:user_id])
      @project.tasks.build(user_id: params[:user_id])
    else
      @project.tasks.build(user_id: current_user.id)
    end
  end

  private

  def project_params
    params.permit(:name, tasks_attributes: [:user_id, :project_id, :name, :done, :id, :due_date,])
  end

end
