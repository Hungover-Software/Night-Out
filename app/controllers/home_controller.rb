# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Home Page Controller (HomeController)
# Controls actions for the user's home page.
# Authors: Logan Fitzgibbons, Cameron Mezzell

class HomeController < ApplicationController
    
    # Method index
    # Parameters: None
    # Allows for a list of events associated with the currently logged in user to be generated.
    # Output: all events associated with the current user
    def index
        #.order("DATE(events.date) asc, TIME(events.time) asc")
        @events = Event.distinct.left_outer_joins(:event_invites).where("events.user_id = ? OR event_invites.user_id = ?", session[:user_id], session[:user_id])
    end
    
    # Method friends
    # Parameters: None
    # The friends method is used to build the friends list and has 3 areas; Requests is made up of friend request that the user has
    # sent out and have not been accepted. Pending is made up of request sent to the user that the user has not yet accepted.
    # Friends is the list of all users who were sent a request by the current user and have accepted it.
    # Output: all friend request associated with the current user.
    def friends
        @requests = []
        friend_requests = Friend.where('user_receiver_id = ? AND accepted = ?', session[:user_id], false)
        friend_requests.each do |friend|
            @requests.push(User.find(friend.user_sender_id))
        end
        
        @pending = []
        pending_friends = Friend.where('user_sender_id = ? AND accepted = ?', session[:user_id], false)
        pending_friends.each do |friend|
            @pending.push(User.find(friend.user_receiver_id))
        end
        
        @friends = Friend.where('user_sender_id=?', session[:user_id]).or(Friend.where('user_receiver_id=?', session[:user_id])).where('accepted=?', true)
        
        @friends = []
        friend_sender = Friend.where('user_sender_id = ? AND accepted = ?', session[:user_id], true)
        friend_sender.each do |friend|
            @friends.push(User.find(friend.user_receiver_id))
        end
        friend_receiver = Friend.where('user_receiver_id = ? AND accepted = ?', session[:user_id], true)
        friend_receiver.each do |friend|
            @friends.push(User.find(friend.user_sender_id))
        end
        
        #puts Friend.where('user_sender_id=? AND accepted=?', session[:user_id], true)
        #puts @friends.inspect
        return
    end
    
    # Method send_friend_request
    # Parameters: None
    # Method called when the user submits the new friend request form
    # Output: new friend record in friends table
    def send_friend_request
        # Grab an object from params to make life easier
        friend = params[:friend]
        
        # Grab the two users this friend request is referring to
        @user_sender = User.find(session[:user_id])
        @user_receiver = User.where("email = '#{friend[:receiver_email]}'").first
        
        if @user_sender == nil or @user_receiver == nil
            puts "One of these people don't exist!"
            return
        end
        
        # Ensure the user isn't adding themselves
        if @user_sender[:email] == @user_receiver[:email]
            puts "You can't add yourself, silly!"
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
        
        redirect_to friends_path
    end
    
    # Method respond_to_friend_request
    # Parameters: params
    # Allows for a user to respond to a pending friend request
    # Output: updates or deletes friend record
    def respond_to_friend_request
        puts params.inspect
        @friend_request = Friend.where('user_sender_id = ? AND user_receiver_id = ?', params[:sender_id], session[:user_id])
        
        if params[:accept]
            puts "ACCEPTED!"
            @friend_request[0][:accepted] = true
            @friend_request[0].save
        else
            puts "DECLINED!"
            @friend_request[0].destroy
        end
        redirect_to friends_path
    end

end
