class CreateAccountController < ApplicationController
  
  before_action :save_login_state, :only => [:new, :create]

  def list
    #DEBUG
    puts User.all
  end
 
  def user_params
   params.require(:user).permit(:email, :password, :password_confirmation, :preferred_name, :phone)
  end

  def new
      #Signup Form
      @user = User.new
  end

  def create
    
    @user = User.new(user_params)

    if @user.save
    	#flash[:notice] = "You Signed up successfully"
      #flash[:color]= "valid"
      render "create"
    else
      #flash[:notice] = "Form is invalid"
      #flash[:color]= "invalid"
      render "new"
    end
    self.list
    
  end

end
