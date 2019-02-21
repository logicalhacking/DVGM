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
      @user = User.new(:login => users_params[:login], :role => users_params[:role], :password => Digest::MD5.hexdigest(users_params[:password]))
      if users_params[:password] == users_params[:password_confirmation] and @user.save
        flash[:success] = "Account registered!"
        redirect_to root_path
      else
        render :new
      end
    elsif logged_in_as_lecturer
      @user = User.new(:login => users_params[:login], :role => users_params[:role], :password => Digest::MD5.hexdigest(users_params[:password]))
      if users_params[:password] == users_params[:password_confirmation] and @user.save
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

  def reset_password
    if params[:user]
      @user = User.find_by params[:user].permit(:login, :secret_answer)
      if @user
        if params[:user][:password] == params[:user][:password_confirmation]
          @user.update_attributes(:password => Digest::MD5.hexdigest(params[:user][:password]))
          @user.save
          flash[:success] = "Password changed successfully!"
          redirect_to root_url
        else
          flash[:error] = "Passwords don't match!"
          render :reset_password_for_user
        end
      else
        flash[:error] = "Wrong answer!"
        @user = User.find_by :login => params[:user][:login]
        render :reset_password_for_user
      end
    elsif params[:login]
      @user = User.find_by(:login => params[:login])
      if @user and @user.secret_question
        render :reset_password_for_user
      else
        flash[:error] = "This user does not exist or have a secret answer set!"
        redirect_to reset_password_url
      end
    else
      @user = User.new
      render :reset_password
    end
  end

private
  def users_params
    params.require(:user).permit(:login, :role, :password, :password_confirmation)
  end
end
