class TasksController < ApplicationController

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @user = current_user
    redirect_to user_lists_path(@user)
  end

  def update
    @user = current_user
    @task = Task.find(params[:id])

    @task.update(task_params)
    redirect_to user_lists_path(@user)
  end

  private

  def task_params
    @task = Task.find(params[:id])
    params.permit(:done, :id, :list_id)
  end

end
