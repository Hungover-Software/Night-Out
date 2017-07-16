class HomeController < ApplicationController
    
    def index
        @events = Events.where("user_id = ?", session[:current_user_id])
    end
    
    def friends
        @fiends = Friends.where('(user_sender_id = ? or user_receiver_id = ?) and accepted = true', session[:current_user_id], session[:current_user_id])
    end
    
    def send_friend_request(params)
        #DEBUG
        puts "here!"
        puts params.inspect
        
        #If a user sends a friend request where one already exists, just make accepted = true
        
        @user_sender = User.where("email = '#{params[:sender_email]}'")
        #@user_sender = User.where("id = '#{session[:current_user_id]}'")
        @user_receiver = User.where("email = '#{params[:receiver_email]}'")
        
        #DEBUG
        puts "Inspecting the objects"
        puts @user_sender.inspect
        puts @user_receiver.inspect
        puts @user_sender[0].inspect
        
        #@friend_request = Friend.new(friend_request_params)
        @friend_request = Friend.new(:user_sender_id => @user_sender[0][:user_id], :user_receiver_id => @user_receiver[0][:user_id], :accepted => false)
        #@friend_request.save
        
        #DEBUG 
        puts @friend_request.inspect
    end
    
    def friend_request_params
        params.require(:friend).permit(:sender_email, :receiver_email)
    end

end
