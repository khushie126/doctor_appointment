class RemoveForeignkeyInPatients < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :patients, column: :medical_unit_id
  end
end
