class ListsController < ApplicationController
before_action :current_user

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
    @user = current_user
    @list = List.new(list_params)
      if @list.save
          redirect_to user_lists_path
      else
        render :new
      end
  end

  def edit
    @user = current_user
    @list = List.find(params[:id])
    @list.tasks.build
  end

  def update
    @list = List.find(params[:id])
    @user = current_user
    if @list.update(list_params)
      redirect_to user_lists_path
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to user_lists_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :due_date, :sub_type, user_ids:[], tasks_attributes: [:id, :name, :done])
  end

end
