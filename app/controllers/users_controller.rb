class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:user][:username]
    @user.save

    redirect_to @user
  end

  def show
    @user = current_user
  end
end
