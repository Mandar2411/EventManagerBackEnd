class AddCoulmnsToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :start_date, :datetime
    add_column :events, :end_date, :datetime
    add_column :events, :venue, :string
    add_column :events, :event_type, :string
    add_column :events, :fee, :integer
    add_column :events, :image_url, :string
  end
end
