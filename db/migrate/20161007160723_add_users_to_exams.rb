class AddUsersToExams < ActiveRecord::Migration[5.0]
  def change
    add_column :exams, :user_id, :integer
  end
end
