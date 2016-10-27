class RenameColumnToDocuments < ActiveRecord::Migration[5.0]
  def change
    rename_column :documents, :name, :title
    rename_column :documents, :content, :document_link
  end
end
