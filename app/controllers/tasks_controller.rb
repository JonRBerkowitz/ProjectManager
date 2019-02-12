class TasksController < ApplicationController
  before_action :authentication_required

  def destroy
    @task = Task.find(params[:id])
    @project = Project.find_by_id(@task.project_id)
    @task.destroy
    if @project.tasks.empty?
      @project.destroy
    end
    single_user?
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    single_user?
  end

  def single_user?
    if flash[:edit_task] == "USER"
      redirect_to user_projects_path(current_user)
    else
      redirect_to projects_path
    end
  end

  private

  def task_params
    @task = Task.find(params[:id])
    params.permit(:name, :done, :project_id, :user_id)
  end

end
