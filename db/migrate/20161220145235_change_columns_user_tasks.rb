class ChangeColumnsUserTasks < ActiveRecord::Migration[5.0]
  def change
    change_column_default :user_tasks, :status, 0
    add_column :user_tasks, :sent_pull_count, :integer, default: 0
    drop_table :user_task_histories
  end
end
