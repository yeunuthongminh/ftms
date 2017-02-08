class CreateCourseSubjectTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :course_subject_teams do |t|
      t.belongs_to :team, foreign_key: true
      t.belongs_to :course_subject, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
