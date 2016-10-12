class AddPercentOfQuestionsToSubjectDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :subject_details, :percent_of_questions, :string
  end
end
