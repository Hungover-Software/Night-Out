# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Account Creation Controller (CreateAccountController)
# Controls the actions for the createaccount/new.html.erb page
# createaccount/new.html.erb is used to signup for a new account with the Night Out app.
# Authors: Nathan Lyon, Logan Fitzgibbons

class CreateAccountController < ApplicationController
  
  before_action :save_login_state, :only => [:new, :create]
  skip_before_action :require_login, only: [:new, :create]

  # Method list
  # Parameters: None
  # The list method is primarily used for debugging purposes and displayes all the tuples in the User table
  # Output: will display to the console, does not return a value
  def list
    #DEBUG
    puts User.all
  end
 
  # Method user_params
  # Parameters: :email, :password, :password_confirmation, :preferred_name, :phone
  # The user_params method takes it's input parameters from submit button on the createaccount/new.html.erb
  # page and ensures that they have values before passing them to another function.
  # Output: returns the values of the parameters or creates an error message if they are not pressent
  def user_params
   params.require(:user).permit(:email, :password, :password_confirmation, :preferred_name, :phone)
  end

  # Method new
  # Parameters: none
  # The new method creates a new user object with no values initialized
  # Output: boolean value based on success or failure of the action
  def new
      #Signup Form
      @user = User.new
  end

  # Method create
  # Parameters: user_params method
  # The create method creates a new user object with the values submitted to the user_params method.
  # If a save action is successful it will redirect to the login page
  # If a save action is unsucessful it will rerender the createaccount/new.html.erb page to try again
  # Output: none
  def create
    
    @user = User.new(user_params)

    if @user.save
    	redirect_to login_path
    else
      render "new"
    end
    self.list
    
  end

end
