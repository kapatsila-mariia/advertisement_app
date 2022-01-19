class CreateAdvertisements < ActiveRecord::Migration[6.1]
  def change
    create_table :advertisements do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
