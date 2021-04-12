# frozen_string_literal: true

class AddIndexToPrioritiesComparisonVal < ActiveRecord::Migration[6.1]
  def change
    add_index :priorities, :comparison_val, unique: true
  end
end
