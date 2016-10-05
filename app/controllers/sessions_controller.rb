class SessionsController < ApplicationController
  before_action :authenticate_user#, only: [:home, :profile, :setting, :new_post]
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
      redirect_to action: :home
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def home
     #stream
  end

  def profile
  end

  def setting
  end

  def new_post
  end

  def search
    @users = User.where("name LIKE '%#{params[:name]}%'")
  end




end
