class HomeController < ApplicationController
    
    def index
        @events = Events.where("user_id = ?", session[:current_user_id])
    end
    
    def friends
        @friends = []
        #@fiends = Friends.where('(user_sender_id = ? or user_receiver_id = ?) and accepted = true', session[:current_user_id], session[:current_user_id])
    end
    
    def send_friend_request
        puts 'In send_friend_request!'
        #If a user sends a friend request where one already exists, just make accepted = true
        friend = params[:friend]
        @user_sender = User.where("email = '#{friend[:sender_email]}'")
        #@user_sender = User.where("id = '#{session[:current_user_id]}'")
        @user_receiver = User.where("email = '#{friend[:receiver_email]}'")
        
        
        @friend_request = Friend.new(
            :user_sender_id => @user_sender[0][:id], 
            :user_receiver_id => @user_receiver[0][:id], 
            :accepted => false
        )
        
        @friend_request.save
    end
    
    def respond_to_friend_request(params)
        puts params.inspect
        if params[:response]
            @friend_request = Friend.find(params[:id])
            puts @friend_request.inspect
            @friend_request[:accepted] = true
            puts @friend_request.inspect
            @friend_request.save
        else
            puts params[:id]
            Friend.delete("where id = ?", params[:id])
        end
    end
        
end
