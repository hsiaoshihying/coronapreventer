class CreateCustomerUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
