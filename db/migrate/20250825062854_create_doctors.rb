class CreateDoctors < ActiveRecord::Migration[8.0]
  def change
    create_table :doctors do |t|
      t.integer :phone_number
      t.string :image 
   
      t.timestamps
    end
  end
end
