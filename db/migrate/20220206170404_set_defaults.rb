class SetDefaults < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role_id, 1
    change_column_default :advertisements, :status, "created"
  end
end
