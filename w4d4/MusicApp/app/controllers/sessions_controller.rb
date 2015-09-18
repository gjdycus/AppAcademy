class SessionsController < ApplicationController
  before_action :require_not_logged_in, except: [:destroy]

  def create
    @user = User.find_by_credentials(
      params[:session][:user][:email],
      params[:session][:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = ["Invalid email/password combination"]
      render :new
    else
      log_in!(@user)
    end
  end

  def new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
