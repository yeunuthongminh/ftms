class RenameProgLanguageToLanguage < ActiveRecord::Migration[5.0]
  def change
    rename_table :programming_languages, :languages
    rename_column :profiles, :programming_language_id, :language_id
    rename_column :categories, :programming_language_id, :language_id
    rename_column :courses, :programming_language_id, :language_id
    rename_column :statistics, :programming_language_id, :language_id
  end
end
