# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create a user
admin = User.find_or_create_by!(email: 'admin@email.com', role: :admin) do |user|
  user.password = 'test.123'
  user.save!
end

user = User.find_or_create_by!(email: 'user@email.com', role: :user) do |user|
  user.password = 'test.123'
  user.save!
end


events = [
  { name: 'Event 1', description: 'Event 1 description', organizer: 'Event 1 organizer', status: 'Event 1 status', user: user, start_time: Time.now, end_time: Time.now + 1.hour },
  { name: 'Event 2', description: 'Event 2 description', organizer: 'Event 2 organizer', status: 'Event 2 status', user: user, start_time: Time.now, end_time: Time.now + 1.hour },
  { name: 'Event 3', description: 'Event 3 description', organizer: 'Event 3 organizer', status: 'Event 3 status', user: user, start_time: Time.now, end_time: Time.now + 1.hour },
  { name: 'Event 4', description: 'Event 4 description', organizer: 'Event 4 organizer', status: 'Event 4 status', user: user, start_time: Time.now, end_time: Time.now + 1.hour },
  { name: 'Event 5', description: 'Event 5 description', organizer: 'Event 5 organizer', status: 'Event 5 status', user: user, start_time: Time.now, end_time: Time.now + 1.hour },
]

# Create a event
events.each do |event|
  Event.find_or_create_by!(name: event[:name]) do |e|
    e.description = event[:description]
    e.organizer = event[:organizer]
    e.status = event[:status]
    e.user = event[:user]
    e.start_time = event[:start_time]
    e.end_time = event[:end_time]
  end
end
