class UsersController < ApplicationController
before_action :disable_nav, only:[:new, :create]

  def new
    @user = User.new
  end

  def index
    redirect_to signup_path
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
    @user = current_user
  end
end

private

def user_params
  params.require(:user).permit(:email, :password)
end
