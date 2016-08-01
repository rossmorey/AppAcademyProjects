


class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

    def create
      user = User.new(params[:user].permit(:name, :email))
      # debugger
       if user.save
         render json: user
      else
        render(
        json: user.errors.full_messages, status: :unprocessable_entity
        )
      end
    end

    def show
      user = User.find_by(id: params[:id])
      # fail
      render json: user
    end

    def update
      user = User.find_by(id: params[:id])
      if user.update(user_params)
        render json: user
     else
       render(
       json: user.errors.full_messages, #status: #:unprocessable_entity
       )
     end
    end

    def destroy
      user = User.find_by(id: params[:id])
      if user.destroy
        render json: user
      else
        render text: 'user does not exist.'
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
