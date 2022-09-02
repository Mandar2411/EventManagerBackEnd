class AddColumntoEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :reg_start_date, :datetime
    add_column :events, :reg_end_date, :datetime
  end
end
