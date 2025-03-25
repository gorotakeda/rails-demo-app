class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.time :start_time
      t.integer :capacity
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
