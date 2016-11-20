class CreateProgramHierarchies < ActiveRecord::Migration
  def change
    create_table :program_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :program_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "program_anc_desc_idx"

    add_index :program_hierarchies, [:descendant_id],
      name: "program_desc_idx"
  end
end
