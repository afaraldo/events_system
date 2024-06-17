# == Schema Information
#
# Table name: event_registrations
#
#  id          :bigint           not null, primary key
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :bigint           not null
#  event_id    :bigint           not null
#
# Indexes
#
#  index_event_registrations_on_attendee_id               (attendee_id)
#  index_event_registrations_on_attendee_id_and_event_id  (attendee_id,event_id) UNIQUE
#  index_event_registrations_on_event_id                  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (event_id => events.id)
#
FactoryBot.define do
  factory :event_registration do
    event { nil }
    attendee { nil }
    status { 'MyString' }
  end
end
