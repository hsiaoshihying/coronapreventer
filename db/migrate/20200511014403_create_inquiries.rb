class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.text :content
      t.text :reply
      t.references :customer_user, foreign_key: true
      t.references :store_user, foreign_key: true

      t.timestamps
    end
  end
end
