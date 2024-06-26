# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :string
#  end_time    :datetime
#  name        :string
#  organizer   :string
#  start_time  :datetime
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  enum :status, { planned: 'Planned', announced: 'Announced', open: 'Open', closed: 'Closed', cancelled: 'Cancelled' }, default: :planned

  belongs_to :user
  has_many :event_registrations, dependent: :destroy
  has_many :attendees, through: :event_registrations

  validates :name, :description, :start_time, :end_time, :status, presence: true
  validates_comparison_of :start_time, greater_than: Time.zone.today
  validates_comparison_of :end_time, greater_than: :start_time, other_than: Time.zone.today

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description end_time id id_value name organizer start_time status updated_at user_id]
  end
end
