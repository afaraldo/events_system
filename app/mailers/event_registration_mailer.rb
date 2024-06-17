class EventRegistrationMailer < ApplicationMailer
  default from: 'iceberg.04@gmail.com'

  def invitation_email
    @event_registration = params[:event_registration]
    @event = @event_registration.event
    @edit_link = edit_event_event_registration_url(@event, @event_registration)

    mail(to: @event_registration.attendee.email, subject: 'You are invited to an event')
  end
end
