class AddUniqueIndexToEventRegistrations < ActiveRecord::Migration[7.1]
  def change
    add_index :event_registrations, %i[attendee_id event_id], unique: true
  end
end
