class HomeController < ApplicationController
    
    def index
        @events = Event.order("DATE(date) asc, TIME(time) asc").left_outer_joins(:event_invites).where("events.user_id = ? OR event_invites.user_id = ?", session[:user_id], session[:user_id])
    end
    
    def friends
        @friends = []
        #@fiends = Friends.where('(user_sender_id = ? or user_receiver_id = ?) and accepted = true', session[:current_user_id], session[:current_user_id])
    end
    
    def send_friend_request
        # Grab an object from params to make life easier
        friend = params[:friend]
        
        # Ensure the user isn't adding themselves
        if friend[:sender_email] == friend[:receiver_email]
            puts "You can't add yourself, silly!"
            return
        end
        
        # Grab the two users this friend request is referring to
        @user_sender = User.where("email = '#{friend[:sender_email]}'")
        # @user_sender = User.where("id = '#{session[:current_user_id]}'")
        @user_receiver = User.where("email = '#{friend[:receiver_email]}'")
    
        if @user_sender.size == 0 or @user_receiver.size == 0
            puts "One of these people don't exist!"
            return
        end
        
        # See if this friend request was already sent. If so, do nothing.
        request = Friend.where("user_sender_id = #{@user_sender[:id]} and user_receiver_id = #{@user_receiver[:id]}")
        
        if request.size > 0
            # Obviously do something else, but just return for now.
            puts "Request already in, not going to process"
            return
        end
        
        # See if the other user has already sent a request. If so, accept their friend request.
        request = Friend.where("user_sender_id = #{@user_receiver[:id]} and user_receiver_id = #{@user_sender[:id]}")
        
        if request.size > 0
            if request[0][:accepted]
                puts "Already friends!"
                return
            else
                request[0][:accepted] = true
                request[0].save
                puts "Accepted their friend request"
                return
            end
        end
        
        # If we are here, it is actually a new friend request. Create and save it!
        @friend_request = Friend.new(
            :user_sender_id => @user_sender[:id], 
            :user_receiver_id => @user_receiver[:id], 
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
    
    def respond_to_friend_request
        # Grab variable to make it look better
        friend = params[:friend]
        
        # If the friend request was accepted, update the DB
        if friend[:accepted]
            friend.save
            
        # Otherwise delete the record
        else
            friend.destroy
        end
    end

end
