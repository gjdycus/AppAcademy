class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :require_not_logged_in, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:session][:user][:user_name],
      params[:session][:user][:password]
    )

    if @user.nil?
      flash.now.alert = "Username/password combination incorrect"
    else
      log_in!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
