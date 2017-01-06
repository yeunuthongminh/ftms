class AddTypeToUserCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_courses, :user_type
    add_column :user_courses, :type, :string
    remove_index :user_courses, name: "index_user_courses_on_user_id_and_course_id"
    add_index :user_courses, [:course_id, :user_id, :type], unique: true
  end
end
