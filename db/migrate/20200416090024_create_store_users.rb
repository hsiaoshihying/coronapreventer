class CreateStoreUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :store_users do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
