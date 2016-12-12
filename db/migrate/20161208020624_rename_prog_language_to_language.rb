class RenameProgLanguageToLanguage < ActiveRecord::Migration[5.0]
  def change
    rename_table :programming_languages, :languages
    rename_column :profiles, :programming_language_id, :language_id
    remove_foreign_key :categories, column: :programming_language_id
    rename_column :categories, :programming_language_id, :language_id 
    rename_column :courses, :programming_language_id, :language_id
    remove_foreign_key :statistics, column: :programming_language_id
    rename_column :statistics, :programming_language_id, :language_id
    add_foreign_key :categories, :languages, index: true
    add_foreign_key :statistics, :languages, index: true
  end
end
