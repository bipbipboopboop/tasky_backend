class AddIsUrgentAndIsCompletedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_urgent, :boolean
    add_column :tasks, :is_completed, :boolean
  end
end
