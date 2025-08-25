class DoctorTimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :location
end
