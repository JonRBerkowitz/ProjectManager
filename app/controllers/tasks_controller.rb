class TasksController < ApplicationController
  before_action :authentication_required

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @user = current_user
    redirect_to user_projects_path(@user)
  end

  def update
    @user = current_user
    @task = Task.find(params[:id])

    @task.update(task_params)
    redirect_to user_projects_path(@user)
  end

  private

  def task_params
    @task = Task.find(params[:id])
    params.permit(:name, :done, :id, :project_id, :user_id)
  end

end
