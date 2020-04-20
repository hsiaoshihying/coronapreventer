class AddResetToCustomerUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_users, :reset_digest, :string
    add_column :customer_users, :reset_sent_at, :datetime
  end
end
