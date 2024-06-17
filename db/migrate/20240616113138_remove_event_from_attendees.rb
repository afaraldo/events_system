class RemoveEventFromAttendees < ActiveRecord::Migration[7.1]
  def change
    remove_reference :attendees, :event, null: false, foreign_key: true
  end
end
