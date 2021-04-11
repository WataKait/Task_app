# frozen_string_literal: true

class AddForeignKeyLabelIdToLabelTasks < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :label_tasks, :labels
  end
end
