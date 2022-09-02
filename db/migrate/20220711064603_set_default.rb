class SetDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_role, :integer, default: 2
  end
end
