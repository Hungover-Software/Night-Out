class EventController < ApplicationController
    
    def list
        #@events = Event.where(:user_id => session[:user_id]).includes(:event_invites).where("event_invites.user_id" => session[:user_id])
        #@events = Event.includes(:event_invites).where("event_invites.user_id = #{session[:user_id]}").references(:event_invites)
        @events = Event.where("user_id = ?", session[:user_id])
    end
    
    def show
        @event = Event.find(params[:id])
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
    
    def addPoll
    end
    
    def addOption
    end
    
    def vote
    end
    
    def comment
        comment = Comment.new(comment_params)
        comment.save
        
        redirect_to home_path
    end
    
    def invite
        invite_user = User.where(:email => invite_params()[:email])
        
        if invite_user == nil
            return
        else
            if invite_user.id == session[:user_id]
                return
            else
                invite = EventInvite.new(:user_id => invite_user[:id], :accepted => false)
                invite.save
            end
        end
        
        redirect_to home_path
    end
    
    def event_params
        params.require(:user).permit(:name, :date, :time)
    end
    
    def invite_params
        params.require(:user).permit(:email)
    end
    
    def comment_params
        confirmed_params = params.require(:user).permit(:comment)
        confirmed_params[:user_id] = session[:user_id]
        confirmed_params[:timestamp] = DateTime.now
        confirmed_params[:event_id] = @event.id
        confirmed_params
    end
end
