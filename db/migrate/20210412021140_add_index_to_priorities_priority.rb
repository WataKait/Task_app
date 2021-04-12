# frozen_string_literal: true

class AddIndexToPrioritiesPriority < ActiveRecord::Migration[6.1]
  def change
    add_index :priorities, :priority, unique: true
  end
end
