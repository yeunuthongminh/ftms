class FixForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :questions, :subjects
    add_foreign_key :answers, :questions
    add_foreign_key :results, :questions
    add_foreign_key :results, :answers
    add_foreign_key :results, :exams
    add_foreign_key :exams, :users
    add_foreign_key :exams, :user_subjects
  end
end
