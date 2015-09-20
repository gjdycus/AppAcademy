class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    user = User.find_by(session_token: session[:session_token])

    return user unless user.nil?
  end

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to bands_url
  end

  def logged_in?
    !current_user.nil?
  end

  def require_log_in
    unless logged_in?
      flash[:errors] = ["Log in for access"]
      redirect_to new_session_url
    end
  end

  def require_not_logged_in
    if logged_in?
      flash[:errors] = ["You are already logged in"]
      redirect_to bands_url
    end
  end
end
