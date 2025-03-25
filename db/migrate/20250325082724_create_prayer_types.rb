class CreatePrayerTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :prayer_types do |t|
      t.string :name, null: false
      t.text :description
      t.integer :price, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
