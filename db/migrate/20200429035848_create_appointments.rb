class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :customer_user, foreign_key: true
      t.references :store_user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :customer_users, [:customer_user_id, :created_at]
    add_index :store_users, [:store_user_id]
    add_index :products, [:product_id]
  end
end
