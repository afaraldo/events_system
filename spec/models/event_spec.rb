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
# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    event = Event.new(
      name: 'Test Event',
      description: 'This is a test event.',
      start_time: DateTime.now + 1.day,
      end_time: DateTime.now + 2.days,
      status: 'planned',
      user:
    )
    expect(event).to be_valid
  end

  it 'is not valid if end_time is before start_time' do
    event = Event.new(
      name: 'Test Event',
      description: 'This is a test event.',
      start_time: DateTime.now + 2.days,
      end_time: DateTime.now + 1.day,
      status: 'planned',
      user:
    )
    expect(event).to_not be_valid
  end

  it 'is not valid if start_time is not in the future' do
    event = Event.new(
      name: 'Test Event',
      description: 'This is a test event.',
      start_time: DateTime.now - 1.day,
      end_time: DateTime.now + 1.day,
      status: 'planned',
      user:
    )
    expect(event).to_not be_valid
    expect(event.errors[:start_time]).to include("must be greater than #{Time.zone.today}")
  end
end
