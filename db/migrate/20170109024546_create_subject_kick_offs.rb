class CreateSubjectKickOffs < ActiveRecord::Migration[5.0]
  def change
    create_table :subject_kick_offs do |t|
      t.string :name
      t.text :content
      t.belongs_to :subject, index: true, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :subject_kick_offs, :deleted_at
  end
end
