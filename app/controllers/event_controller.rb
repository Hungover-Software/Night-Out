# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Event Creation Controller (EventController)
# Controls action of the event creation page - event/new.html.erb
# Include: None
# Authors: Cameron Mezzell, Logan Fitzgibbons

class EventController < ApplicationController
    
    # Method show
    # Parameters: None
    # Set up and grab necessary variables or objects to display all the event information.
    # Output:
    def show
        @event = Event.includes(:event_invites, :polls => [:options]).find(params[:id])
        puts @event.inspect
        puts @event.event_invites.inspect
        puts @event.polls.inspect
        
        @admin = User.find(@event.user_id)
        
        @invited = []
        event_invites = @event.event_invites
        event_invites.each do |invite|
            @invited.push({user: User.find(invite.user_id), accepted: invite.accepted})
        end
        
        
        @admin_privileges = @event.user_id == session[:user_id]
        
        if @admin_privileges
            @accepted = true
        else
            @accepted = @event.event_invites.select { |invite| invite.user_id == session[:user_id] }[0].accepted
        end
    end
    
    # Method new
    # Parameters: None
    # Establishes new empty event. No polls, no comments, no invites.
    # Output:
    def new
        @event = Event.new
    end
    
    # Method create
    # Parameters: None
    # Create a new empty event and places it in the database. No polls, no comments, no invites.
    # Output:
    def create
        @event = Event.new(event_params)
        @event.user_id = session[:user_id]
        @event.save
        
        redirect_to :action => "show", :id => @event.id
    end
    
    # Method destroy
    # Parameters: None
    # Completely destroy the given event. All associated polls, comments, invites, options, and votes are also destroyed.
    # Output:
    def destroy
        Event.find(params[:id]).destroy
        
        redirect_to home_path
    end
    
    # Method add_poll
    # Parameters: None
    # Create a new poll for a new stop. No initial options.
    # Output:
    def add_poll
        poll = Poll.new(poll_params)
        poll.save
        
        puts poll.inspect
        puts params.inspect
        
        redirect_to :action => "show", :id => params[:id]
    end

    # Method remove_poll
    # Parameters: None
    # Unimplemented
    # Output:
    def remove_poll
        Poll.find(params[:poll_id]).destroy
        redirect_to :action => "show", :id => params[:id]
    end
    
    # Method add_option
    # Parameters: None
    # Make a new option for a particular poll for users to vote on.
    # Output:
    def add_option
        option = Option.new(option_params)
        option.save
        
        puts option.inspect
        
        redirect_to :action => "show", :id => params[:id]
    end
    
    # Method remove_option
    # Parameters:
    # Unimplemented
    # Output:
    def remove_option
    end
    
    # Method vote
    # Parameters: None
    # Saves the user's vote. If the user already voted, it moves their vote to the new option.
    # Output:
    def vote
        new_vote = Vote.new(vote_params)
        
        poll = Poll.find(Option.find(new_vote.option_id).poll_id)
        
        already_voted = false
        
        poll.options.each do |option|
           option.votes.each do |vote|
              if vote.user_id == session[:user_id]
                  vote.option_id = new_vote.option_id
                  vote.save
                  already_voted = true
                  break
              end
           end
           if already_voted
               break
           end
        end
        
        if not already_voted
            new_vote.save
        end
        
        redirect_to :action => "show", :id => params[:id]
    end
    
    # Method comment
    # Parameters: None
    # Unimplemented
    # Output:
    def comment
        comment = Comment.new(comment_params)
        comment.save
        
        redirect_to :action => "show", :id => params[:id]
    end
    
    # Method invite
    # Parameters: None
    # Given an email, send an invitation to the user with that email to this event.
    # Output:
    def invite
        @invite_user = User.where(:email => invite_params()[:email])[0]
        @event = Event.find(params[:id])
        
        if @invite_user == nil
            return
        else
            if @invite_user.id == session[:user_id]
                return
            else
                invite = EventInvite.new(:event_id => @event[:id], :user_id => @invite_user[:id], :accepted => false)
                invite.save
            end
        end
        
        redirect_to :action => "show", :id => params[:id]
    end
    
    # Method accept_invite
    # Parameters: None
    # Changes the user's invite status to 'accepted'
    # Output:
    def accept_invite
        @invite = EventInvite.where(:event_id => params[:id], :user_id => session[:user_id])[0]
        @invite.accepted = true
        @invite.save
        
        redirect_to :action => "show", :id => params[:id]
    end
    
    # Method decline_invite
    # Parameters: None
    # Removes the EventInvite object from the database and returns the user to the home page.
    # Output:
    def decline_invite
        EventInvite.where(:event_id => params[:id], :user_id => session[:user_id])[0].destroy
        
        redirect_to home_path
    end
    
    # Method event_params
    # Parameters: None
    # Ensures all required parameters are given.
    # Output: Hash containing all the params to create a new Event object
    def event_params
        params.require(:user).permit(:name, :date, :time)
    end
    
    # Method invite_params
    # Parameters: None
    # Ensures all required parameters are given.
    # Output: Hash containing all the params to create a new EventInvite object
    def invite_params
        params.require(:event_invite).permit(:email)
    end
    
    # Method comment_params
    # Parameters: None
    # Ensures all required parameters are given.
    # Output: Hash containing all the params to create a new comment object
    def comment_params
        confirmed_params = params.require(:user).permit(:comment)
        confirmed_params[:user_id] = session[:user_id]
        confirmed_params[:timestamp] = DateTime.now
        confirmed_params[:event_id] = @event.id
        confirmed_params
    end
    
    # Method poll_params
    # Parameters: None
    # Ensures all required parameters are given.
    # Output: Hash containing all the params to create a new Poll object
    def poll_params
        confirmed_params = params.require(:poll).permit(:name)
        confirmed_params[:event_id] = params[:id]
        confirmed_params
    end
    
    # Method option_params
    # Parameters: None
    # Ensures all required parameters are given.
    # Output: Hash containing all the params to create a new Option object
    def option_params
        confirmed_params = params.require(:option).permit(:name, :poll_id)
        confirmed_params[:user_id] = session[:user_id]
        confirmed_params
    end
    
    # Method vote_params
    # Parameters: None
    # Ensures all required parameters are given.
    # Output: Hash containing all of the params to create a new Vote object
    def vote_params
        confirmed_params = params.require(:vote).permit(:option_id)
        confirmed_params[:user_id] = session[:user_id]
        confirmed_params
    end
end
