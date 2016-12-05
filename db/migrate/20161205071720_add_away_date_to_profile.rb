class AddAwayDateToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :away_date, :datetime
    add_column :profiles, :comeback_date, :datetime
  end
end
