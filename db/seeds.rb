require 'faker'
# ---------- USERS ----------
5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "123456",
    role: rand(0..2),
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name
  )
end
puts "5 users created."

# ---------- MEDICAL UNITS ----------
medical_units = []
3.times do
  medical_units << MedicalUnit.create!(
    name: "#{Faker::Company.name} Medical Unit",
    phone_number: Faker::PhoneNumber.subscriber_number(length: 10).to_i
  )
end
puts "3 medical units created."

# ---------- LOCATIONS ----------
locations = []
medical_units.each do |unit|
  2.times do
    locations << Location.create!(
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      zip_code: Faker::Address.zip_code.to_i,
      medical_unit: unit
    )
  end
end
puts "6 locations created."

specializations = %w[Cardiology Pediatrics Orthopedics Dermatology Neurology].map do |spec|
  Specialization.create!(specialization_category: spec)
end

puts "5 specializations created."
# ---------- DOCTORS ----------
doctors = []
5.times do
  doctor = Doctor.create!(
    phone_number: Faker::PhoneNumber.subscriber_number(length: 10).to_i,
    image: Faker::Avatar.image,
    medical_unit: medical_units.sample
  )
  doctor.specializations << specializations.sample(rand(1..2))
  doctors << doctor
end
puts "5 doctors created."

# ---------- PATIENTS ----------
patients = []
10.times do
  patients << Patient.create!(
    phone_number: Faker::PhoneNumber.subscriber_number(length: 10).to_i,
    image: Faker::Avatar.image,
  )
end
puts "10 patients created."
# ---------- DOCTOR TIME SLOTS ----------
time_slots = []
doctors.each do |doctor|
  3.times do
    start_time = Faker::Time.forward(days: 5, period: :morning)
    end_time = start_time + 30.minutes
    time_slots << DoctorTimeSlot.create!(
      doctor: doctor,
      start_time: start_time,
      end_time: end_time,
      date: start_time.to_date,
      location: locations.sample
    )
  end
end
puts "15 doctor time slots created."
# ---------- APPOINTMENTS ----------
20.times do
  start_time = Faker::Time.forward(days: 7, period: :afternoon)
  end_time = start_time + 10.minutes
  Appointment.create!(
    start_time: start_time,
    end_time: end_time,
    booked_date: Faker::Date.backward(days: 3),
    available_date: start_time.to_date,
    status: rand(0..2),
    description: Faker::Lorem.sentence(word_count: 6),
    booking_number: rand(100..900),
    patient: patients.sample,
    doctor: doctors.sample,
    location: locations.sample
  )
end
puts "20 appointments created."

