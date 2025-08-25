class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :specialized_doctors, dependent: :destroy
  has_many :specializations, through: :specialized_doctors
  has_many :doctor_time_slots, dependent: :destroy
  belongs_to :medical_unit
  has_many :patients, through: :appointments
end
