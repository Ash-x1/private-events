class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])

    
    if @event.private? && @event.creator != current_user && !@event.attendees.include?(current_user)
      redirect_to root_path, alert: "This event is private."
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  private 

  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :private)
  end
end
