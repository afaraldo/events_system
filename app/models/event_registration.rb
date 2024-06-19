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
class EventRegistration < ApplicationRecord
  audited only: [:status]
  enum :status, { pending: 'PENDING', accepted: 'ACCEPTED', declined: 'DECLINED', checked_in: 'CHECKIN', no_show: 'NO_SHOW' }, default: :pending

  belongs_to :event
  belongs_to :attendee

  accepts_nested_attributes_for :attendee

  delegate :name, :email, to: :attendee, prefix: true

  validates :status, presence: true
  validates :attendee, uniqueness: { scope: :event } # Also added a unique index to the database

  after_create_commit -> { broadcast_append_to 'event_registrations' }
  after_update_commit -> { broadcast_replace_to 'event_registrations' }
  after_destroy_commit -> { broadcast_remove_to 'event_registrations' }

  after_create_commit -> { broadcast_replace_to "counters_event_#{event.id}", target: "counters_event_#{event.id}", partial: 'events/counters', locals: { event: } }
  after_update_commit -> { broadcast_replace_to "counters_event_#{event.id}", target: "counters_event_#{event.id}", partial: 'events/counters', locals: { event: } }
  after_destroy_commit -> { broadcast_replace_to "counters_event_#{event.id}", target: "counters_event_#{event.id}", partial: 'events/counters', locals: { event: } }

  def self.ransackable_attributes(_auth_object = nil)
    %w[attendee_id created_at event_id id id_value status updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[attendee audits event]
  end
end
