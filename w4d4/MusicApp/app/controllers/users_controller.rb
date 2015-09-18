class UsersController < ApplicationController
  before_action :require_not_logged_in, only: [:create, :new]
  before_action :require_log_in, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
