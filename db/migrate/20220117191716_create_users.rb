class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :user do |t|
      t.role_id :integer
      t.string :login
      t.string :password
      t.string :email

      t.timestamps
    end
  end
end
