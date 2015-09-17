class UsersController < ApplicationController
  before_action :require_not_logged_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.notice = "User #{@user.user_name} created successfully"
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now.alert = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
