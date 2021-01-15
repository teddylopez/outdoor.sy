class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :vehicle_type, default: 0
      t.string :vehicle_name
      t.decimal :vehicle_length_ft, precision: 6, scale: 2

      t.timestamps
    end
  end
end
