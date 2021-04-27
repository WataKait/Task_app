# frozen_string_literal: true

class AddIndexPrioritiesColumns < ActiveRecord::Migration[6.1]
  def change
    add_index :priorities, :name, unique: true
    add_index :priorities, :priority, unique: true
  end
end
