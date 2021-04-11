# frozen_string_literal: true

class CreateLabelTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :label_tasks do |t|
      t.integer :label_id, null: false
      t.integer :task_id, null: false

      t.timestamps
    end
  end
end
