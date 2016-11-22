class AddAbbrToUniversities < ActiveRecord::Migration[5.0]
  def change
    add_column :universities, :abbreviation, :string
  end
end
