class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.date :start_training_date
      t.date :leave_date
      t.date :finish_training_date
      t.boolean :ready_for_project
      t.date :contract_date
      t.string :naitei_company
      t.belongs_to :university, foreign_key: true
      t.date :graduation
      t.belongs_to :language, foreign_key: true
      t.belongs_to :trainee_type, foreign_key: true
      t.belongs_to :user_status, foreign_key: true
      t.belongs_to :stage, foreign_key: true
      t.belongs_to :organization, foreign_key: true
      t.float :working_day
      t.belongs_to :program, foreign_key: true
      t.string :staff_code
      t.integer :division
      t.date :join_div_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
