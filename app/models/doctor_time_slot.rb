class DoctorTimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :location
  has_many :appointments, dependent: :destroy
end
