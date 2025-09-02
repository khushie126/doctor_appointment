class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  belongs_to :location
  belongs_to :doctor_time_slot, optional: true
  enum :status, [ :scheduled, :not_scheduled ]
  before_validation :set_end_time
  validates :start_time, presence: true
  validate :validate_no_overlap
  validate :fits_within_doctor_slot

  def set_end_time
    self.end_time = start_time + APPOINTMENT_DURATION if start_time.present?
  end

  def validate_no_overlap
    overlapping = Appointment.where(doctor_id: doctor_id, location_id: location_id)
                             .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlapping.exists?
      errors.add(:base, "This time slot is already booked. Please choose another time.")
    end
  end

  def fits_within_doctor_slot
  return unless start_time.present? && doctor_id.present?

  slot = DoctorTimeSlot.where(doctor_id: doctor_id, location_id: location_id)
                       .where("date = ?", doctor_time_slot&.date)
                       .where("start_time <= ? AND end_time >= ?", doctor_time_slot&.start_time, doctor_time_slot&.end_time)
                       .first

  errors.add(:base, "Appointment does not fit within doctor's available slot") if slot.nil?
  end
end
