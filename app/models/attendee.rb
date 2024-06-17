# == Schema Information
#
# Table name: attendees
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_attendees_on_email  (email) UNIQUE
#
class Attendee < ApplicationRecord
  has_many :event_registrations, dependent: :destroy
  has_many :events, through: :event_registrations

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email id id_value name status updated_at]
  end
end
