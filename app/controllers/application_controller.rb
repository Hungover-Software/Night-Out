# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Account Creation Controller (CreateAccountController)
# Controls the actions for the createaccount/new.html.erb page
# createaccount/new.html.erb is used to signup for a new account with the Night Out app.
# Include: SessionsHelper
# Authors: Nathan Lyon,

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  protected
  
  # Method authenticate_user
  # Parameters:
  #
  # Output:
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
  
  # Method save_login_state
  # Parameters: None
  # The save_login_state method prevents users from accessing the Signup & Login Page without logout
  # Output: boolean true or false
  def save_login_state
    if session[:user_id]
            redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
