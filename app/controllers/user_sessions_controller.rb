class UserSessionsController < ApplicationController
  def create
    @user = User.find_by :login => user_session_params[:login], :password => Digest::MD5.hexdigest(user_session_params[:password])
    if @user
      @user.session = SecureRandom.hex
      @user.save
      cookies[:session] = @user.session

      flash[:success] = "Login successful!"
      redirect_back_or_default root_path
    else
      flash[:error] = "Login failed!"
      render :action => :new, :location => sign_out_url
    end
  end

  def destroy
    @user = User.find_by :session => cookies[:session]
    @user.session = nil
    @user.save
    redirect_to sign_in_url
  end

private
  def user_session_params
    params.permit(:login, :password)
  end
end
