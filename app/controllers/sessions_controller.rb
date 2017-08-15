# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Sessions Controller (SessionsController)
#
# Authors: Logan Fitzgibbons

class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  

  # Method new
  # Parameters: None
  # todo: add function
  # Output:
  def new
  end

  # Method create
  # Parameters: None
  #
  # Output:
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to home_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  # Method destroy
  # Parameters: None
  #
  # Output:
  def destroy
    log_out
    redirect_to root_url
  end
end
