class AddUserrolesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :userroles, foreign_key: true
  end
end
