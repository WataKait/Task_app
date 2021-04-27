# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true
      t.references :label, foreign_key: true
      t.references :priority, foreign_key: true
      t.references :status, foreign_key: true
      t.datetime :time_limit
      t.text :description

      t.timestamps
    end
  end
end
