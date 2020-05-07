class AddIndexToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :product_name, :string
  end
end
