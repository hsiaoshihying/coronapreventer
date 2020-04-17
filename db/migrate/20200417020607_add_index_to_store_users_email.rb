class AddIndexToStoreUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :store_users, :email, unique: true
  end
end
