class AddLabelIdToLabelTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :label_tasks, :label, foreign_key: true
  end
end
