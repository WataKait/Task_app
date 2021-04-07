class AddTaskIdToLabelTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :label_tasks, :task, foreign_key: true
  end
end
