class WelcomeController < ApplicationController
  
  before_action :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
	before_action :save_login_state, :only => [:index, :login, :login_attempt]
  
  def index
    #home Page
  end
  
	def create
			#Profile Page
	end

	def login_attempt
		puts "PARAMS!"
		puts params.inspect
		authorized_user = User.authenticate(params[:user][:email], params[:user][:password])
		if authorized_user
			puts "LOGGED IN!"
			session[:user_id] = authorized_user.id
			flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
			#redirect_to(:action => 'home')
			render "create"


		else
			puts "NOT LOGGED IN!"
			flash.notice = "Post successfully created"
			flash[:notice] = "Invalid Username or Password"
        	flash[:color]= "invalid"
			render "index"	
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to :action => 'index'
	end


end
