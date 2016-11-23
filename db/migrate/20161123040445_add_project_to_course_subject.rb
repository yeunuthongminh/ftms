class AddProjectToCourseSubject < ActiveRecord::Migration[5.0]
  def change
    add_reference :course_subjects, :project, foreign_key: true
  end
end
