class CreateUserCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_courses do |t|
      t.string :type
      t.belongs_to :user, foreign_key: true
      t.belongs_to :course, foreign_key: true
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
