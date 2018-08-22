class UsersController < ApplicationController
  def index
    if logged_in_as_admin
      @users = User.all
      render :index_admin
    elsif logged_in_as_lecturer
      @users = User.where(:role => "student")
      render :index_lecturer
    else
      flash[:error] = "You do not have access to this site."
      redirect_to root_url
    end
  end

  def new
    if logged_in_as_admin or logged_in_as_lecturer
      @user = User.new
    else
      flash[:error] = "You do not have access to this site."
      redirect_to root_url
    end
  end

  def create
    if logged_in_as_admin
      @user = User.new(users_params)
      if @user.save
        flash[:success] = "Account registered!"
        redirect_to root_path
      else
        render :new
      end
    elsif logged_in_as_lecturer
      @user = User.new(users_params)
      if @user.save
        flash[:success] = "Account registered!"
        redirect_to root_path
      else
        render :new
      end
    else
      flash[:error] = "You do not have access to this site."
        redirect_to root_url
    end
  end

private
  def users_params
    params.require(:user).permit(:login, :role, :password, :password_confirmation)
  end
end
