class AddUserTypeToUserCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :user_courses, :user_type, :integer
  end
end
