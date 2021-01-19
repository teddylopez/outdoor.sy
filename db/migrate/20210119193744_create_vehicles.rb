class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.decimal :length, precision: 6, scale: 2
      t.references :customer, index: true
      t.integer :vehicle_type, default: 0

      t.timestamps
    end
  end
end
