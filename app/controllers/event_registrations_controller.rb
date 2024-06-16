class EventRegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_event_registration, only: %i[show edit update destroy]

  def new
    @event_registration = @event.event_registrations.build
    @event_registration.build_attendee
  end

  def create
    attendee = Attendee.find_by(email: event_registration_params.dig('attendee_attributes', 'email'))

    @event_registration = if attendee.nil?
                            @event.event_registrations.build(event_registration_params)
                          else
                            @event.event_registrations.build(attendee:)
                          end

    respond_to do |format|
      if @event_registration.save
        format.html { redirect_to @event, notice: 'Attendee was successfully created and invited.' }
        format.json { render :show, status: :created, location: [@event, @event_registration] }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def show; end

  def update
    respond_to do |format|
      if @event_registration.update(event_registration_params)
        format.html { redirect_to edit_event_event_registration_path(@event_registration.event, @event_registration), notice: 'Attendee status was successfully updated.' }
        format.json { render :show, status: :ok, location: [@event, @event_registration] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event_registration.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Attendee was successfully removed from the event.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_registration
    @event_registration = @event.event_registrations.find(params[:id])
  end

  def event_registration_params
    params.require(:event_registration).permit(:status, attendee_attributes: %i[name email])
  end
end
