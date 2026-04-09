class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @event.event_attendances.create(attendee: current_user)

    redirect_to @event
  end
end
