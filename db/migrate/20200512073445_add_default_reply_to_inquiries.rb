class AddDefaultReplyToInquiries < ActiveRecord::Migration[6.0]
  def change
    change_column :inquiries, :reply, :text, :default => "None"
  end
end
