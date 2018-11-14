class ListsController < ApplicationController

  def index
    @lists = current_user.lists
    @user = current_user
  end

  def new
    @list = List.new
    @user = current_user
  end

end
