class AddColumnToCourseSubject < ActiveRecord::Migration[5.0]
  def change
    add_column :course_subjects, :link_github, :string
    add_column :course_subjects, :link_heroku, :string
  end
end
