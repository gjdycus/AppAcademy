class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to track_url(params[:track_id])
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(params[:track_id])
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.destroy
      redirect_to track_url(params[:track_id])
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(params[:track_id])
    end
  end

  private
  def note_params
    params[:note][:user_id] = current_user.id
    params.require(:note).permit(:user_id, :track_id, :body)
  end
end
