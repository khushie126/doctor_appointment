class ChangeColumnTypeInDoctors < ActiveRecord::Migration[8.0]
  def change
     change_column :doctors, :phone_number, :bigint
  end
end
