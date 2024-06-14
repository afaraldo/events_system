# frozen_string_literal: true

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
FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Sample Event #{n}" }
    description { 'Event Description' }
    start_time { DateTime.now }
    end_time { DateTime.now + 1.hour }
    organizer { 'Organizer Name' }
    status { 'Upcoming' }
    association :user
  end
end
