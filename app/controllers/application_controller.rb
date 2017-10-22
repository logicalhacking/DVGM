class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_as_student, :logged_in_as_lecturer,
    :logged_in_as_admin, :kick_out

private
  def kick_out
    flash[:error] = "You do not have access to this site."
    redirect_to root_url
  end

  def logged_in_as_student
    return (current_user and current_user.role == "student")
  end

  def logged_in_as_lecturer
    return (current_user and current_user.role == "lecturer")
  end

  def logged_in_as_admin
    return (current_user and current_user.role == "admin")
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def store_location
    session[:return_to] = request.original_url
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
