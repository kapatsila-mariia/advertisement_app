class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :advertisement_id
      t.string :comment_text, null:false
      
      
      t.timestamps
    end
  end
end
