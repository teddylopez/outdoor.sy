class RemoveVehicleColumnsFromCustomersTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :vehicle_type
    remove_column :customers, :vehicle_name
    remove_column :customers, :vehicle_length_ft
  end
end
