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

  has_many :event_registrations
  has_many :attendees, through: :event_registrations

  validates :email, presence: true, uniqueness: true
end
