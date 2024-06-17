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
# spec/factories/events.rb
FactoryBot.define do
  factory :event do
    name { 'Event Name' }
    description { Faker::Lorem.paragraph }
    organizer { Faker::Name.name }
    start_time { Faker::Time.forward(days: 23, period: :morning) }
    end_time { start_time + 2.hours }
    status { Event.statuses.keys.sample }
    user

    trait :planned do
      status { 'planned' }
    end

    trait :announced do
      status { 'announced' }
    end

    trait :open do
      status { 'open' }
    end

    trait :closed do
      status { 'closed' }
    end

    trait :cancelled do
      status { 'cancelled' }
    end
  end
end
