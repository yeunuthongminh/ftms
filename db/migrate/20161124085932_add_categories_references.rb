class AddCategoriesReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :exams, :category, foreign_key: true
    add_reference :questions, :category, foreign_key: true
  end
end
