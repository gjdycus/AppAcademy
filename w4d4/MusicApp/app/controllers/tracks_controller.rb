class TracksController < ApplicationController
  before_action :require_log_in

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @track = Track.new
    @album_id = params[:album_id]
    render :new
  end

  def edit
    @track = Track.find(params[:id])
    @album_id = @track.album_id
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @album_id = @track.album_id

    if @track.destroy
      redirect_to album_url(@album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :show
    end
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :ttype, :lyrics)
  end
end
