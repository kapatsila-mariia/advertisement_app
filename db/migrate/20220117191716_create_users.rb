class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :role_id
      t.string :login, unique:true
      t.string :password
      t.string :email, null:false

      t.timestamps
    end
  end
end
