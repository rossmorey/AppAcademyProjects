class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.validate_user(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
