class CreateCourseSubjectRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :course_subject_requirements do |t|
      t.references :project_requirement
      t.references :course_subject
    end
  end
end
