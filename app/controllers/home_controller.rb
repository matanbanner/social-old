class HomeController < ApplicationController
  before_action :authenticate_user, only: [:index]
  before_action :save_login_state, only: [:login, :login_attempt] #skip login if user is logged in already


  def login
    #login form
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

  def logout
    session[:user_id] = nil
    redirect_to action: :login
  end


  def sign_up
    redirect_to controller: :users, action: :new
  end



  def index
    @posts = @current_user.followings_posts
  end


# change after creating test branch

end
