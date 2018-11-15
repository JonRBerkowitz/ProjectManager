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
          redirect_to edit_user_list_path(@user, @list)
      else
        render :new
      end
  end

  def edit
    @user = current_user
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:title, :due_date, :sub_type, user_ids:[], tasks_attributes: [:name, :done])
  end

end
