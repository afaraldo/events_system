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
# spec/models/attendee_spec.rb
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it 'is valid with valid attributes' do
    attendee = Attendee.new(
      name: 'John Doe',
      email: 'john.doe@example.com'
    )
    expect(attendee).to be_valid
  end

  it 'is not valid without an email' do
    attendee = Attendee.new(
      name: 'John Doe',
      email: nil
    )
    expect(attendee).to_not be_valid
    expect(attendee.errors[:email]).to include("can't be blank")
  end

  it 'is not valid with a duplicate email' do
    Attendee.create(
      name: 'Jane Doe',
      email: 'jane.doe@example.com'
    )
    attendee = Attendee.new(
      name: 'John Doe',
      email: 'jane.doe@example.com'
    )
    expect(attendee).to_not be_valid
    expect(attendee.errors[:email]).to include('has already been taken')
  end

  it 'is not valid with an invalid email format' do
    attendee = Attendee.new(
      name: 'John Doe',
      email: 'invalid_email'
    )
    expect(attendee).to_not be_valid
    expect(attendee.errors[:email]).to include('is invalid')
  end

  it 'has many event registrations' do
    association = described_class.reflect_on_association(:event_registrations)
    expect(association.macro).to eq :has_many
  end

  it 'has many events through event registrations' do
    association = described_class.reflect_on_association(:events)
    expect(association.macro).to eq :has_many
    expect(association.options[:through]).to eq :event_registrations
  end
end
