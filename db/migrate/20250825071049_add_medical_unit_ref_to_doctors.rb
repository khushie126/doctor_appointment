class AddMedicalUnitRefToDoctors < ActiveRecord::Migration[8.0]
  def change
    add_reference :doctors, :medical_unit, null: false, foreign_key: true
  end
end
