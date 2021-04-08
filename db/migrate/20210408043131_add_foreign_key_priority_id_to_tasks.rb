class AddForeignKeyPriorityIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tasks, :priorities
  end
end
