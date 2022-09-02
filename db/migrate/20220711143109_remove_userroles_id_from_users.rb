class RemoveUserrolesIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :userroles_id, :integer
  end
end
