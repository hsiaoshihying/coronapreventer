class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :total_num
      t.integer :order_num, default: 0
      t.references :store_user, foreign_key: true

      t.timestamps
    end
    add_index :products, [:store_user_id, :created_at]
  end
end
