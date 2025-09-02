class DoctorTimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :location
  has_many :appointments, dependent: :destroy
  SLOT_DURATION = 30.minutes
  before_validation :set_date
  before_validation :set_end_time
  validate :validate_no_overlap
  private

  def set_date
    self.date ||= start_time.to_date if start_time.present?
  end
  
    def set_end_time
    self.end_time = start_time + SLOT_DURATION if start_time.present?
  end

  def validate_no_overlap
    overlapping = DoctorTimeSlot.where(doctor_id: doctor_id, location_id: location_id, date: date)
                             .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlapping.exists?
      errors.add(:base, "This time slot is already booked. Please choose another time.")
    end
  end
end
