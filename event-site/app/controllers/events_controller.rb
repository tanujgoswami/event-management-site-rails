class EventsController < ActionController::Base

  def create
    @event = current_user.organized_events.new(event_params)
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date,
                                                       :location,
                                                       :agenda,
                                                       :address)
  end

end
