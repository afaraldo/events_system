class EventAttendeesController < ApplicationController
  before_action :set_event
  before_action :set_event_attendee, only: %i[edit update destroy]

  def new
    @event_attendee = @event.event_attendees.build
    @attendee = Attendee.new
  end

  def create
    @attendee = Attendee.find_or_initialize_by(email: attendee_params[:email])
    @attendee.assign_attributes(name: attendee_params[:name])
    @event_attendee = @event.event_attendees.build(attendee: @attendee, status: attendee_params[:status])

    respond_to do |format|
      if @attendee.save && @event_attendee.save
        AttendeeMailer.invitation_email(@event_attendee).deliver_later
        format.html { redirect_to @event, notice: 'Attendee was successfully created and invited.' }
        format.json { render :show, status: :created, location: [@event, @attendee] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @event_attendee.update(event_attendee_params)
        format.html { redirect_to @event, notice: 'Attendee status was successfully updated.' }
        format.json { render :show, status: :ok, location: [@event, @event_attendee] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event_attendee.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Attendee was successfully removed from the event.' }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_attendee
    @event_attendee = @event.event_attendees.find(params[:id])
  end

  def attendee_params
    params.require(:attendee).permit(:name, :email, :status)
  end

  def event_attendee_params
    params.require(:event_attendee).permit(:status)
  end
end
