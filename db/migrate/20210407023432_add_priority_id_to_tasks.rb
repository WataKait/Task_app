class AddPriorityIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :priority, foreign_key: true
  end
end
