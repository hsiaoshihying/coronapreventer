class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :customer_user, foreign_key: true
      t.references :store_user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :appointments, [:customer_user_id, :created_at]
  end
end
