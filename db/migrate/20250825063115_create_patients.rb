class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.integer :phone_number
      t.string :image 
      t.timestamps
    end
  end
end
