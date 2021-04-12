# frozen_string_literal: true

class CreatePriorities < ActiveRecord::Migration[6.1]
  def change
    create_table :priorities do |t|
      t.integer :comparison_val, null: false
      t.string :priority, null: false

      t.timestamps
    end
  end
end
