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

  def new
    @project = Project.new
  end

  def show
    @user = current_user
    @users = User.all
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @project, include: ['tasks', 'tasks.user']}
    end
  end

  def create
    project = Project.create(project_params)
    render json: project, status: 201
  end

  def edit
    project = Project.find(params[:id])
    render json: project, status: 201
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    render json: @project, status: 201
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

  private

  def project_params
    params.permit(:name, tasks_attributes: [:user_id, :project_id, :name, :done, :id, :due_date,])
  end

end
