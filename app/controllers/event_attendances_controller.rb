class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    current_user.attended_events << event
    redirect_to event, notice: 'You are now attending this event.'
  end

  def destroy
    event = Event.find(params[:event_id])
    current_user.attended_events.delete(event)
    redirect_to event, notice: 'You are no longer attending this event.'
  end
end
