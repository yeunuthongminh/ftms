class AddCategoriesReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :exams, :categories, foreign_key: true
    add_reference :questions, :categories, foreign_key: true
  end
end
