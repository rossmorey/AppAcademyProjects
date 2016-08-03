class UsersController < ApplicationController

  before_action :redirect_to_cats

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def redirect_to_cats
    redirect_to cats_url if current_user
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
