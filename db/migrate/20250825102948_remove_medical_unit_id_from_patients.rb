class RemoveMedicalUnitIdFromPatients < ActiveRecord::Migration[8.0]
  def change
    
    remove_column :patients, :medical_unit_id, :bigint
  end
end
