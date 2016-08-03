class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      # render json: @user
      login_user!(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
