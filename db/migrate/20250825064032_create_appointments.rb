class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :booked_date
      t.datetime :available_date
      t.integer :status
      t.text :description
      t.integer :booking_number
      t.references :patient, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.timestamps
    end
  end
end
