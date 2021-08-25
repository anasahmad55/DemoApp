class ApplicationController < ActionController::Base
  helper_method :currentUser, :logged_in?
  def currentUser
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!currentUser
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must be log in"
      redirect_to login_path
    end
  end
end
