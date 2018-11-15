class TasksController < ApplicationController

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @user = current_user
    redirect_to user_lists_path(@user)
  end

end
