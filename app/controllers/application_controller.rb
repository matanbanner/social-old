class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user, except: [:login, :login_attempt]
  before_action :save_login_state, only: [:login, :login_attempt] #skip login if user is logged in already

  def login
    #show the view
  end

  def logout
    session[:user_id] = nil
    redirect_to action: :login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:login_email], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to action: :index
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end


  protected

  def authenticate_user
    if session[:user_id]
       # set current user object to @current_user object variable
      @current_user = User.find(session[:user_id])
      return true
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

end
