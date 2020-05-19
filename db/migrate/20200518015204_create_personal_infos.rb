class CreatePersonalInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :personal_infos do |t|
      t.string :mynumber
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
