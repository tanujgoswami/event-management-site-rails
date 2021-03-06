class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :accept_request, :reject_request]
  before_action :event_owner!, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @events = Event.tagged_with(params[:tag])
    elsif params[:keywords].present?
      @keywords= params[:keywords]
      event_search_term = EventSearchTerm.new(@keywords)
      @events = Event.where(
          event_search_term.where_clause,
          event_search_term.where_args).
          order(event_search_term.order)
    else
      @events = Event.all
    end
  end

  def show
    event_organizer_id = @event.organizer_id
    @organizer = User.find(event_organizer_id)

    @pending_requests = @event.pending_requests

    @accepted_attendees = @event.accepted_attendees
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.organizer_id = current_user.id
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event.id, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @attendance = Attendance.join_event(current_user.id, params[:event_id], 'request_sent')
    'Request Sent' if @attendance.save
    respond_with @attendance
  end

  def accept_request
    @attendance = Attendance.find_by(id: params[:attendance_id]) rescue nil
    @attendance.accept!
    'Applicant Accepted' if @attendance.save
    respond_with(@attendance)
  end

  def reject_request
    @attendance = Attendance.where(params[:attendance_id]) rescue nil
    @attendance.reject!
    'Applicant Rejected' if @attendance.save
    respond_with(@attendance)
  end

  private

  def event_owner!
    authenticate_user!
    if @event.organizer_id != current_user.id
      redirect_to events_path
      flash[:notice] = "You do not have the permission to either edit or delete this event posting"
    end
  end

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :start_date, :end_date, :location,
                                                                    :agenda,
                                                                    :address,
                                                                    :organizer_id,
                                                                    :all_tags)
    end
end
