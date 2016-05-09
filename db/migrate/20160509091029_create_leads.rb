class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :screen_name
      t.string :tw_userId
      t.string :card
      t.string :token

      t.index :email

      t.timestamps null: false
    end
  end
end
