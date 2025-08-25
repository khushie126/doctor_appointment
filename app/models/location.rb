class Location < ApplicationRecord
  belongs_to :medical_unit
  has_many :doctor_time_slots
  has_many :appointments
end
