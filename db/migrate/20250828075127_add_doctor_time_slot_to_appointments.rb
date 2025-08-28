class AddDoctorTimeSlotToAppointments < ActiveRecord::Migration[8.0]
  def change
        add_reference :appointments, :doctor_time_slot, foreign_key: true
  end
end
