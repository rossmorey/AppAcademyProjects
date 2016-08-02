class ContactsController < ApplicationController
  def index
  @contacts = Contact.all
  render json: @contacts
  end

  def show
  @contact = Contact.find_by(id: params[:id])
  render json: @contact
  end

  def create
      @contact = Contact.new(params_contact)
      if @contact.save
        render json: @contact
     else
       render(
       json: @contact.errors.full_messages, status: :unprocessable_entity
       )
     end
   end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    if @contact.destroy
      render json: @contact
   else
     render text: "I AM INDESTRUCABLE!!!"
   end
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    if @contact.update(params_contact)
      render json: @contact
   else
     render(
     json: @contact.errors.full_messages, status: :unprocessable_entity
     )
   end

  end


  private
  def params_contact
    params.require(:contact).permit(:name, :email, :user_id)
  end

end
