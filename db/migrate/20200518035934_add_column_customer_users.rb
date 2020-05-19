class AddColumnCustomerUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_users, :mynumber, :string
    add_column :customer_users, :address, :string
  end
end
