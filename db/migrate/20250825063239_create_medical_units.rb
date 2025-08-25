class CreateMedicalUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :medical_units do |t|
      t.string :name
      t.integer :type
      t.integer :phone_number
      t.timestamps
    end
  end
end
