class CatRentalRequestsController < ApplicationController

  def new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.create!(cat_rental_request_params)
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def approve
    CatRentalRequest.find(params[:id]).approve!
  end

  def deny
    CatRentalRequest.find(params[:id]).deny!
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end
end
