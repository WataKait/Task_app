class AddForeignKeyTaskIdToLabelTasks < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :label_tasks, :tasks
  end
end
