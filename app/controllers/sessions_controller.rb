class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_credentials(*session_params.values)
    if @user.nil?
      flash.now[:errors] = ['Invalid Credentials ']
      render :new
    else
      login_user!(@user)
    end
  end

  def destroy
    logout_user!

    redirect_to new_session_url

  end


  private

  def session_params
    params.require(:sessions).permit(:user_name, :password)
  end

end
