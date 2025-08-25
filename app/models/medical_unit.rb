class MedicalUnit < ApplicationRecord
  has_many :locations
  has_many :doctor_time_slots
  has_many :doctor_time_slots, through: :locations
  has_many :doctors , through: :doctor_time_slots
  enum :unit_type, [:hospital, :clinic]
end
