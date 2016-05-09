class EventsController < ActionController::Base

  before_filter :authenticate_user!

  def create
    @event = current_user.organized_events.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Successful creation of event" }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date,
                                                       :location,
                                                       :agenda,
                                                       :address)
  end

end
