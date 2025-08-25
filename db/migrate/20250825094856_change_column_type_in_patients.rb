class ChangeColumnTypeInPatients < ActiveRecord::Migration[8.0]
  def change
    change_column :patients, :phone_number, :bigint
  end
end
