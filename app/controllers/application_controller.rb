class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  
  include SessionsHelper
  protected
  def authenticate_user
  	unless session[:user_id]
  		redirect_to(:controller => 'sessions', :action => 'login')
  		return false
  	else
      # set current_user by the current user object
      @current_user = User.find session[:user_id] 
  		return true
  	end
  end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
            redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
  
  private
  
  def require_login
    unless logged_in?
      flash[:error] = "Not logged in!"
      redirect_to login_url
    end
  end

end
