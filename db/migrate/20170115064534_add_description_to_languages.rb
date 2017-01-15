class AddDescriptionToLanguages < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :image, :string
    add_column :languages, :description, :text
  end
end
