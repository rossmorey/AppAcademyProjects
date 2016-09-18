class ContactShareController < ApplicationController
  def create
    @contactshare = ContactShare.new(contact_share_params)
    if @contactshare.save
      render json: @contactshare
    else
      render(
      json: @contact_share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contactshare = ContactShare.find_by(id: params[:id])
    if @contactshare.destroy
      render json: @contactshare
    else
      render text: "No Destroy!!"
    end
  end

  private
  def contact_share_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end
