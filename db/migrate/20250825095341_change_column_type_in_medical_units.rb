class ChangeColumnTypeInMedicalUnits < ActiveRecord::Migration[8.0]
  def change
     change_column :medical_units, :phone_number, :bigint
  end
end
