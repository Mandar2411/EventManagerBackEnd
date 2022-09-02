class CreateUserroles < ActiveRecord::Migration[7.0]
  def change
    create_table :userroles do |t|
      t.string :role_name
      t.timestamps
    end
  end
end
