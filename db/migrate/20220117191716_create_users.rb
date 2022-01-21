class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :user do |t|
      t.integer :role_id
      t.string :login, unique:true
      t.string :password, null:false
      t.string :email, null:false

      t.timestamps
    end
  end
end
