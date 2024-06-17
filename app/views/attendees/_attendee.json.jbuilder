json.extract! attendee, :id, :name, :email, :event_id, :created_at, :updated_at
json.url attendee_url(attendee, format: :json)
