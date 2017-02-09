class CreateUserPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :user_programs do |t|
      t.belongs_to :program, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
