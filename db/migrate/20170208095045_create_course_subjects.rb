class CreateCourseSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :course_subjects do |t|
      t.belongs_to :subject, foreign_key: true
      t.string :subject_name
      t.string :subject_description
      t.text :subject_content
      t.string :image
      t.belongs_to :course, foreign_key: true
      t.string :github_link
      t.string :heroku_link
      t.string :redmine_link
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
