class EventController < ApplicationController
    
    def list
        @events = Event.order("DATE(date) asc, TIME(time) asc").left_outer_joins(:event_invites).where("events.user_id = ? OR event_invites.user_id = ?", session[:user_id], session[:user_id])
    end
    
    def show
        @event = Event.includes(:event_invites).find(params[:id])
        
        @admin = @event.user_id == session[:user_id]
        
        if @admin
            @accepted = true
        else
            @accepted = @event.event_invites.select { |invite| invite.user_id == session[:user_id] }[0].status
        end
        
        puts @event.inspect
    end
    
    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(event_params)
        @event.user_id = session[:user_id]
        @event.save
        
        redirect_to home_path
    end
    
    def destroy
        @event.destroy
    end
    
    def add_poll
        poll = Poll.new(poll_params)
        poll.event_id = @event.id
        poll.save
        
        redirect_to home_path
    end
    
    def add_poll(params)
        poll = Poll.new(:name => params[:name])
        poll.event_id = params[:event_id]
        poll.save
        
        #redirect_to home_path
    end
    
    def remove_poll(params)
        Poll.find(params[:id]).destroy
    end
    
    def addOption
    end
    
    def remove_option
    end
    
    def vote
    end
    
    def comment
        comment = Comment.new(comment_params)
        comment.save
        
        redirect_to home_path
    end
    
    def invite
        @invite_user = User.where(:email => invite_params()[:email])[0]
        @event = Event.find(params[:id])
        
        if @invite_user == nil
            return
        else
            if @invite_user.id == session[:user_id]
                return
            else
                invite = EventInvite.new(:event_id => @event[:id], :user_id => @invite_user[:id], :status => false)
                invite.save
            end
        end
        
        redirect_to home_path
    end
    
    def accept_invite
        @event = Event.find(params[:id])
        puts params.inspect
    end
    
    def decline_invite
        @event = Event.find(params[:id])
        puts params.inspect
    end
    
    def event_params
        params.require(:user).permit(:name, :date, :time)
    end
    
    def invite_params
        params.require(:event_invite).permit(:email)
    end
    
    def comment_params
        confirmed_params = params.require(:user).permit(:comment)
        confirmed_params[:user_id] = session[:user_id]
        confirmed_params[:timestamp] = DateTime.now
        confirmed_params[:event_id] = @event.id
        confirmed_params
    end
    
    def poll_params(params)
        params.require(:user).permit(:name)
    end
end
