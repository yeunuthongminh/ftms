class RenameTestsToExams < ActiveRecord::Migration[5.0]
  def change
    rename_table :tests, :exams
    rename_column :results, :test_id, :exam_id
  end
end
