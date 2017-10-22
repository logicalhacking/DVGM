class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      flash[:success] = "Login successful!"
      redirect_back_or_default root_path
    else
      render :action => :new, :location => sign_out_url
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to sign_in_url
  end

private
  def user_session_params
    params.require(:user_session).permit(:login, :password)
  end
end
