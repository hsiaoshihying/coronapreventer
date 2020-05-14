class AddColumnToInquiry < ActiveRecord::Migration[6.0]
  def change
    add_reference :inquiries, :product, foreign_key: true
  end
end
