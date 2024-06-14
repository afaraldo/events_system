class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :organizer
      t.string :status

      t.timestamps
    end
  end
end
