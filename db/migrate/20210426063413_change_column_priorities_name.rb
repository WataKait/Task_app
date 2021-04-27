# frozen_string_literal: true

class ChangeColumnPrioritiesName < ActiveRecord::Migration[6.1]
  def change
    change_column(:priorities, :name, :string, limit: 255)
  end
end
