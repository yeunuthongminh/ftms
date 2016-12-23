class AddTypeToUserCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_courses, :user_type
    add_column :user_courses, :type, :string
  end
end
