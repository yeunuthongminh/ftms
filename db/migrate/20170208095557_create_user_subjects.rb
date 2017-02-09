class CreateUserSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_subjects do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :status
      t.belongs_to :user_course, foreign_key: true
      t.belongs_to :course_subject, foreign_key: true
      t.boolean :current_progress
      t.date :user_end_date
      t.date :start_date
      t.date :end_date
      t.belongs_to :subject, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
