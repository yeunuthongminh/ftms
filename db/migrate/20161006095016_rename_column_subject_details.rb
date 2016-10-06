class RenameColumnSubjectDetails < ActiveRecord::Migration[5.0]
  def change
    rename_column :subject_details, :number_of_test, :number_of_question
    rename_column :subject_details, :time_of_test, :time_of_exam
  end
end
