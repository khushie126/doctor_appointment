json.extract! medical_unit, :id, :name, :unit_type, :created_at, :updated_at

json.location do
  json.id medical_unit.location.id
  json.address medical_unit.location.address
end
