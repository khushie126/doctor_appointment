class CreateSpecializedDoctors < ActiveRecord::Migration[8.0]
  def change
    create_table :specialized_doctors do |t|
      t.references :specialization, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
