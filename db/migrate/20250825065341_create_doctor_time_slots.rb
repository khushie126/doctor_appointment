class CreateDoctorTimeSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :doctor_time_slots do |t|
      t.references :doctor, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :date
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
