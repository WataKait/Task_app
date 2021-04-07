class AddStatusIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :status, foreign_key: true
  end
end
