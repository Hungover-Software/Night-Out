class CreateEventController < ApplicationController
  def create_event
    @event = current_user.events.build(params[:event])
    if @event.save
      redirect_to 'home'
    else
      render 'create_event'
    end
    
    
    
  end
  
  #needs further implementation
  def myevents
  @events = current_user.events.search(params[:search].order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page]))
end
end
