class UsersController < ApplicationController
before_action :disable_nav, only:[:new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_projects_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: 200 
  end


private

def user_params
  params.permit(:email, :password, :task)
end

end
