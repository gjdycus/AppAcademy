class ContactsController < ApplicationController

  def index
    render json: Contact.eager_load(:contact_shares).where("contacts.user_id = ? OR contact_shares.user_id = ?", params[:user_id], params[:user_id])
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    if contact.destroy
      render text: "Delete successful"
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end
  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
