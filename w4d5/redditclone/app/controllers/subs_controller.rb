class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now['errors'] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now['errors'] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub.destroy
      redirect_to subs_url
    else
      flash.now['errors'] = @sub.errors.full_messages
      render :show
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def index
    @subs = Sub.all
    render :index
  end

  private

  def sub_params
    params[:sub][:moderator_id] = current_user.id
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def is_moderator?
    unless self.moderator == current_user
      flash['errors'] = ["You cannot edit unless you're moderator?"]
      redirect_to sub_url(@sub)
    end
  end


end
