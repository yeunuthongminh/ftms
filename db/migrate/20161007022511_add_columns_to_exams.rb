class AddColumnsToExams < ActiveRecord::Migration[5.0]
  def change
    add_column :exams, :status, :integer, default: 0
    add_column :exams, :spent_time, :integer, default: 0
    add_column :exams, :started_at, :datetime
    add_column :exams, :score, :integer, default: 0
    add_column :exams, :duration, :integer
  end
end
