class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zip_code
      t.references :medical_unit, null: false, foreign_key: true
      t.timestamps
    end
  end
end
