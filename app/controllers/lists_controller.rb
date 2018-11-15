class ListsController < ApplicationController

  def index
    @lists = current_user.lists
    @user = current_user
  end

  def new
    @list = List.new
    @user = current_user
    @list.tasks.build
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to user_lists_path
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :due_date, user_ids:[], tasks_attributes: [:name, :done])
  end

end
