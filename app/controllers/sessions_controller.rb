class SessionsController < ApplicationController
before_action :disable_nav, only:[:new]

  def new
    @user = User.new
  end

  def create
    #Oauth Login
    if auth_hash = request.env["omniauth.auth"]
      oauth_email = request.env["omniauth.auth"]["info"]["email"]
      if user = User.find_by(email: oauth_email)
        session[:user_id] = user.id
        redirect_to user_projects_path(user)
      else
        user = User.create(email: oauth_email, password: SecureRandom.hex)
        if user.save
          session[:user_id] = user.id
          redirect_to user_projects_path(user)
        else
          render :new
        end
      end
    else
      #Normal Login
    	@user = User.find_by(:email => params[:email])
      if @user && @user.authenticate(params[:password])
    	 session[:user_id] = @user.id
    	 redirect_to user_projects_path(@user)
      else
        flash.now[:message] = 'Invalid username/password combination'
        render :new
      end
    end
  end

  def destroy
  	reset_session
  	redirect_to login_path
  end

  private



end
