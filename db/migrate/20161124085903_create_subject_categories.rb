class CreateSubjectCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :subject_categories do |t|
      t.references :subject, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
