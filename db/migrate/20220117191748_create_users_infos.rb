class CreateUsersInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :users_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.integer :user_id

      t.timestamps
    end
  end
end
