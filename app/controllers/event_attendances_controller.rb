class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])

    if params[:attendee_id]
      user = User.find(params[:attendee_id])
      @event.event_attendances.create(attendee: user)
    else
      @event.event_attendances.create(attendee: current_user)
    end

    redirect_to @event
  end
end
