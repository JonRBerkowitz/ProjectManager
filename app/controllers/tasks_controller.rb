class TasksController < ApplicationController
  before_action :authentication_required

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
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
    params.permit(:name, :done, :id, :project_id, :user_id)
  end

end
