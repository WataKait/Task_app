# frozen_string_literal: true

class AddForeignKeyUserIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tasks, :users
  end
end
