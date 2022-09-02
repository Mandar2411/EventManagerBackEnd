class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :is_admin, :user_role
  end
end
