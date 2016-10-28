class AddStaffCodeJoinDivDateToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :staff_code, :string
    add_column :profiles, :join_div_date, :date
  end
end
