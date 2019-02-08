class ListsController < ApplicationController
before_action :authentication_required

  def index
    @user = User.find_by_id(params[:user_id])
    if @user
      @lists = @user.lists
    else
      @lists = List.all
    end
    @user = current_user
  end

  def overdue
    @lists = List.overdue
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

      if @list.save!
        if params[:task_field] == "ADD TASK"
          flash[:redirect] = "ADD"
          redirect_to edit_user_list_path(@user, @list)
        else
          redirect_to user_lists_path
        end
      else
        render :new
      end
  end

  def edit
    @user = current_user
    @list = List.find(params[:id])
    if flash[:redirect] == "ADD"
      @list.tasks.build
    end
  end

  def update
    @list = List.find(params[:id])
    @user = current_user
    if @list.update!(list_params)
      if params[:task_field] == "ADD TASK"
        flash[:redirect] = "ADD"
        redirect_to edit_user_list_path(@user, @list)
      else
        redirect_to user_lists_path
      end
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to user_lists_path
  end


  def add_task
    @list = List.find(params[:id])
    @user = current_user
    @list.tasks.build
    render :new
  end

  private

  def list_params
    params.require(:list).permit(:title, :due_date, user_ids:[], tasks_attributes: [:id, :name, :done])
  end

end
