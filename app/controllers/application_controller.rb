class ApplicationController < ActionController::Base

  def current_user
    User.find_by_id(params[:user_id])
  end

end
