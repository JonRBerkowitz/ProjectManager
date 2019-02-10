class ApplicationController < ActionController::Base
 skip_before_action :verify_authenticity_token

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

  def disable_nav
    @disable_nav = true
  end

  helper_method :disable_nav
  helper_method :current_user
end
