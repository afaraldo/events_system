class CreateEventRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :event_registrations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
