class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authentication_required
  	if !logged_in?
  		redirect_to login_path
  	end
  end

  def logged_in?
  	!!current_user
  end

  helper_method :current_user
end
