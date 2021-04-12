# frozen_string_literal: true

class AddForeignKeyStatusIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tasks, :statuses
  end
end
