class SendInvitationEmailJob < ApplicationJob
  queue_as :default

  def perform(event_registration); end
end
