# frozen_string_literal: true

class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :label

      t.timestamps
    end
  end
end
