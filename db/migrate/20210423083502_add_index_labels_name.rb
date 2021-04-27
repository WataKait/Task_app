# frozen_string_literal: true

class AddIndexLabelsName < ActiveRecord::Migration[6.1]
  def change
    add_index :labels, :name, unique: true
  end
end
