class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :require_login, :require_not_logged_in

  def log_in!(user)
    @current_user = user
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login
    unless current_user
      flash.alert = "You must be logged in to access this page"
      redirect_to new_session_url
    end
  end

  def require_not_logged_in
    if current_user
      flash.alert = "You are already logged in."
      redirect_to cats_url
    end
  end

  def user_owns_cat
    unless current_cat.user_id == current_user.id
      flash.alert = "This is not your cat"
      redirect_to cat_path(current_cat)
    end
  end
end
