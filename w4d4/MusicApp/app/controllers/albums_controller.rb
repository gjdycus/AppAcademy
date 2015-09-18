class AlbumsController < ApplicationController
  before_action :require_log_in

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new
    @band_id = params[:band_id]
    render :new
  end

  def edit
    @album = Album.find(params[:id])
    @band_id = @album.band_id
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @band_id = @album.band_id

    if @album.destroy
      redirect_to band_url(@band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :show
    end
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :ttype)
  end
end
