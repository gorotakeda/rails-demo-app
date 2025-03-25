class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prayer_type, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true
      t.date :reserved_date
      t.integer :number_of_people
      t.text :note
      t.string :status

      t.timestamps
      t.index [:reserved_date, :time_slot_id]
    end
  end
end
