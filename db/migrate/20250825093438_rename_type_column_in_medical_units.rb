class RenameTypeColumnInMedicalUnits < ActiveRecord::Migration[8.0]
  def change
     rename_column :medical_units, :type, :unit_type
  end
end
