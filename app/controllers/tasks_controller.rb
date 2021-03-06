class TasksController < ApplicationController
  before_action :authentication_required


  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all
    render json: @tasks, status: 200
  end

  def create
    task = Task.create(task_params)
    render json: task, status: 201
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end

  def show
    @task = Task.find_by_id(params[:id])
    render json: @task, include: ['notes', 'notes.user']
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    render json: @task
  end

  private

  def task_params
    params.permit(:name, :done, :project_id, :user_id, :due_date, :id, notes_attributes: [:task_id, :user_id, :content])
  end

end
