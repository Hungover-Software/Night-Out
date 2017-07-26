class CreateAccountController < ApplicationController
  
  def list
    #DEBUG
    puts User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    #DEBUG
    puts params.inspect
    
    #@user.save
    
    #DEBUG
    self.list
  end
  
  def user_params
    params.require(:user).permit(:email, encrypt_password(:password), :preferred_name, :phone_number)
    
    
    
  end
  

end
