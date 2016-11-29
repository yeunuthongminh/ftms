class AddCategoryQuestionToSubjectDetails < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :questions, :subjects
    add_column :subject_details, :category_questions, :string
  end
end
