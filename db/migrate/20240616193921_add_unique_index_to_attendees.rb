class AddUniqueIndexToAttendees < ActiveRecord::Migration[7.1]
  def change
    add_index :attendees, :email, unique: true
  end
end
